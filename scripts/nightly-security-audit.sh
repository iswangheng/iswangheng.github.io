#!/bin/bash
# OpenClaw 夜间安全巡检脚本 v2.7
# 覆盖 13 项核心指标 + Git 灾备

set -e

OC="${OPENCLAW_STATE_DIR:-$HOME/.openclaw}"
REPORT_DIR="/tmp/openclaw/security-reports"
DATE=$(date +%Y-%m-%d)
REPORT_FILE="$REPORT_DIR/report-$DATE.txt"

mkdir -p "$REPORT_DIR"

echo "🛡️ OpenClaw 每日安全巡检简报 ($DATE)" > "$REPORT_FILE"
echo "========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 1. 平台安全审计
echo "1. 平台审计: " >> "$REPORT_FILE"
if openclaw security audit --deep >> "$REPORT_FILE" 2>&1; then
    echo "   ✅ 已执行原生扫描" >> "$REPORT_FILE"
else
    echo "   ⚠️ 审计执行有警告" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 2. 进程与网络审计
echo "2. 进程网络: " >> "$REPORT_FILE"
LISTEN_PORTS=$(ss -tlnp 2>/dev/null | wc -l)
echo "   监听端口数: $LISTEN_PORTS" >> "$REPORT_FILE"
TOP_PROC=$(ps aux --sort=-%mem 2>/dev/null | head -6 | tail -5 | awk '{print $11}' | xargs basename 2>/dev/null || echo "N/A")
echo "   高内存进程: $TOP_PROC" >> "$REPORT_FILE"
echo "   ✅ 已执行" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 3. 敏感目录变更（最近24h）
echo "3. 目录变更: " >> "$REPORT_FILE"
OC_CHANGES=$(find $OC -type f -mtime -1 2>/dev/null | wc -l)
SSH_CHANGES=$(find ~/.ssh -type f -mtime -1 2>/dev/null | wc -l)
echo "   OpenClaw目录: $OC_CHANGES 个文件" >> "$REPORT_FILE"
echo "   .ssh目录: $SSH_CHANGES 个文件" >> "$REPORT_FILE"
echo "   ✅ 已扫描" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 4. 系统定时任务
echo "4. 系统Cron: " >> "$REPORT_FILE"
SYS_CRON=$(cat /etc/crontab 2>/dev/null | grep -v "^#" | wc -l)
ETC_CRON_D=$(ls /etc/cron.d/ 2>/dev/null | wc -l)
echo "   /etc/crontab: $SYS_CRON 行" >> "$REPORT_FILE"
echo "   /etc/cron.d/: $ETC_CRON_D 个文件" >> "$REPORT_FILE"
echo "   ✅ 已检查" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 5. OpenClaw Cron Jobs
echo "5. 本地Cron: " >> "$REPORT_FILE"
OC_CRON_COUNT=$(openclaw cron list 2>/dev/null | grep -c "cron" || echo "0")
echo "   任务数: $OC_CRON_COUNT" >> "$REPORT_FILE"
echo "   ✅ 列表已获取" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 6. SSH 安全
echo "6. SSH安全: " >> "$REPORT_FILE"
FAILED_SSH=$(grep "Failed password" /var/log/auth.log 2>/dev/null | tail -20 | wc -l || echo "0")
LAST_LOGIN=$(last -1 2>/dev/null | awk '{print $1,$4,$5,$6}' || echo "无记录")
echo "   失败尝试: $FAILED_SSH 次" >> "$REPORT_FILE"
echo "   最近登录: $LAST_LOGIN" >> "$REPORT_FILE"
echo "   ✅ 已审计" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 7. 配置基线校验
echo "7. 配置基线: " >> "$REPORT_FILE"
if [ -f "$OC/.config-baseline.sha256" ]; then
    if sha256sum -c "$OC/.config-baseline.sha256" >> "$REPORT_FILE" 2>&1; then
        echo "   ✅ 哈希校验通过" >> "$REPORT_FILE"
    else
        echo "   🔴 哈希校验失败 - 文件被篡改!" >> "$REPORT_FILE"
    fi
else
    echo "   ⚠️ 基线文件不存在" >> "$REPORT_FILE"
fi
# 权限检查
OPENCLAW_PERM=$(stat -c %a $OC/openclaw.json 2>/dev/null || echo "N/A")
echo "   openclaw.json权限: $OPENCLAW_PERM" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 8. 黄线操作交叉验证
echo "8. 黄线审计: " >> "$REPORT_FILE"
MEMORY_FILES=$(find $OC/memory -name "*.md" -mtime -1 2>/dev/null | wc -l)
SUDO_LOG=$(grep "sudo" /var/log/auth.log 2>/dev/null | tail -10 | wc -l || echo "0")
echo "   memory文件(24h): $MEMORY_FILES" >> "$REPORT_FILE"
echo "   sudo记录(最近): $SUDO_LOG" >> "$REPORT_FILE"
echo "   ✅ 已比对" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 9. 磁盘使用
echo "9. 磁盘容量: " >> "$REPORT_FILE"
ROOT_USAGE=$(df / 2>/dev/null | awk 'NR==2 {print $5}' | tr -d '%')
echo "   根分区: ${ROOT_USAGE}%" >> "$REPORT_FILE"
NEW_BIG_FILES=$(find / -type f -size +100M -mtime -1 2>/dev/null | wc -l)
echo "   新增大文件(>100MB): $NEW_BIG_FILES" >> "$REPORT_FILE"
if [ "$ROOT_USAGE" -gt 85 ]; then
    echo "   🔴 磁盘告警: 超过85%" >> "$REPORT_FILE"
else
    echo "   ✅ 正常" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 10. 环境变量审计
echo "10. 环境变量: " >> "$REPORT_FILE"
GATEWAY_PID=$(pgrep -f "openclaw gateway" | head -1)
if [ -n "$GATEWAY_PID" ]; then
    SENSITIVE_VARS=$(cat /proc/$GATEWAY_PID/environ 2>/dev/null | tr '\0' '\n' | grep -iE "(KEY|TOKEN|SECRET|PASSWORD)" | cut -d= -f1 | sort -u | tr '\n' ',' || echo "无")
    echo "   敏感变量: $SENSITIVE_VARS" >> "$REPORT_FILE"
    echo "   ✅ 已检查" >> "$REPORT_FILE"
else
    echo "   ⚠️ Gateway进程未找到" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 11. 敏感凭证扫描 (DLP)
echo "11. 敏感凭证扫描: " >> "$REPORT_FILE"
PRIV_KEY_PATTERNS=$(grep -rE "0x[a-fA-F0-9]{64}" $OC/memory/ $OC/logs/ 2>/dev/null | wc -l || echo "0")
MNEMONIC_PATTERNS=$(grep -rE "^[a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+ [a-z]+" $OC/memory/ $OC/logs/ 2>/dev/null | wc -l || echo "0")
if [ "$PRIV_KEY_PATTERNS" -gt 0 ] || [ "$MNEMONIC_PATTERNS" -gt 0 ]; then
    echo "   🔴 发现疑似私钥/助记词!" >> "$REPORT_FILE"
else
    echo "   ✅ 未发现明文私钥或助记词" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# 12. Skill/MCP 完整性
echo "12. Skill基线: " >> "$REPORT_FILE"
SKILL_COUNT=$(ls -la $OC/../.openclaw-skills/ 2>/dev/null | grep "^d" | wc -l || echo "0")
echo "   已安装Skill数: $SKILL_COUNT" >> "$REPORT_FILE"
echo "   ✅ 已检查" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# 13. Git 灾备同步
echo "13. 灾备备份: " >> "$REPORT_FILE"
cd $OC
if git rev-parse --git-dir >/dev/null 2>&1; then
    git add -A 2>/dev/null
    if git diff --staged --quiet 2>/dev/null; then
        echo "   ✅ 无变更，无需提交" >> "$REPORT_FILE"
    else
        git commit -m "Nightly security backup $(date +%Y-%m-%d)" 2>/dev/null || echo "   ⚠️ 提交失败" >> "$REPORT_FILE"
        git push origin main 2>/dev/null && echo "   ✅ 已推送至Git" >> "$REPORT_FILE" || echo "   ⚠️ 推送失败" >> "$REPORT_FILE"
    fi
else
    echo "   ⚠️ 非Git仓库，跳过" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

echo "========================================" >> "$REPORT_FILE"
echo "📝 详细报告: $REPORT_FILE" >> "$REPORT_FILE"

# 输出摘要（供 Telegram 推送）
echo "🛡️ OpenClaw 每日安全巡检简报 ($DATE)"
echo ""
cat "$REPORT_FILE"
