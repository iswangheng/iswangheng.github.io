#!/bin/bash
# 链上监控主控制脚本
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="$SKILL_DIR/data"
LOG_FILE="$DATA_DIR/monitor.log"

# 确保数据目录存在
mkdir -p "$DATA_DIR"

# 日志函数
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 加载配置
load_config() {
    if [ ! -f "$DATA_DIR/config.json" ]; then
        log "❌ 配置文件不存在: $DATA_DIR/config.json"
        exit 1
    fi
}

# 测试所有 API 连接
test_apis() {
    log "🔍 测试 API 连接..."
    
    cd "$SCRIPT_DIR"
    
    # 测试 Etherscan
    if node -e "
        const config = require('../data/config.json');
        if (!config.etherscan_api_key) {
            console.log('⚠️  Etherscan API key 未配置');
            process.exit(0);
        }
        const https = require('https');
        const url = \`https://api.etherscan.io/api?module=stats&action=ethprice&apikey=\${config.etherscan_api_key}\`;
        https.get(url, (res) => {
            let data = '';
            res.on('data', chunk => data += chunk);
            res.on('end', () => {
                const json = JSON.parse(data);
                if (json.status === '1') {
                    console.log('✓ Etherscan API 连接成功');
                    process.exit(0);
                } else {
                    console.log('✗ Etherscan API 错误:', json.message);
                    process.exit(1);
                }
            });
        }).on('error', (e) => {
            console.log('✗ Etherscan 连接失败:', e.message);
            process.exit(1);
        });
    " 2>&1 | tee -a "$LOG_FILE"; then
        ETH_OK=0
    else
        ETH_OK=1
    fi
    
    # 测试 Solscan
    log "⚠️  Solscan API 需要手动验证（跳过自动测试）"
    
    # 测试 Telegram
    if node telegram.js test 2>&1 | tee -a "$LOG_FILE"; then
        TG_OK=0
    else
        TG_OK=1
    fi
    
    if [ $ETH_OK -eq 0 ] && [ $TG_OK -eq 0 ]; then
        log "✓ 所有系统正常"
        return 0
    else
        log "✗ 部分系统异常"
        return 1
    fi
}

# 单次扫描
scan() {
    log "🚀 开始扫描..."
    cd "$SCRIPT_DIR"
    
    # ETH 监控
    node eth-monitor.js 2>&1 | tee -a "$LOG_FILE"
    
    # Solana 监控
    node sol-monitor.js 2>&1 | tee -a "$LOG_FILE"
    
    # 新币扫描
    node token-scanner.js 2>&1 | tee -a "$LOG_FILE"
    
    # 更新跟踪数据
    node tracker.js update 2>&1 | tee -a "$LOG_FILE"
    
    log "✓ 扫描完成"
}

# 启动定时监控
start() {
    log "🎯 启动定时监控..."
    
    # 检查是否已在运行
    if pgrep -f "monitor.sh daemon" > /dev/null; then
        log "⚠️  监控已在运行中"
        exit 1
    fi
    
    # 启动守护进程
    nohup "$0" daemon > "$DATA_DIR/daemon.log" 2>&1 &
    log "✓ 监控已启动 (PID: $!)"
}

# 停止监控
stop() {
    log "🛑 停止监控..."
    pkill -f "monitor.sh daemon" || true
    log "✓ 监控已停止"
}

# 守护进程模式
daemon() {
    log "🔄 守护进程启动"
    
    while true; do
        scan
        INTERVAL=$(node -e "console.log(require('$DATA_DIR/config.json').scan_interval_minutes * 60 * 1000)")
        sleep $INTERVAL
    done
}

# 生成周报
weekly_report() {
    log "📊 生成周报..."
    cd "$SCRIPT_DIR"
    node reporter.js weekly 2>&1 | tee -a "$LOG_FILE"
}

# 测试推送
test_push() {
    log "📤 测试 Telegram 推送..."
    cd "$SCRIPT_DIR"
    node telegram.js test 2>&1 | tee -a "$LOG_FILE"
}

# 显示统计
stats() {
    log "📈 显示统计..."
    cd "$SCRIPT_DIR"
    node reporter.js stats 2>&1 | tee -a "$LOG_FILE"
}

# 主命令
case "${1:-help}" in
    test)
        load_config
        test_apis
        ;;
    scan)
        load_config
        scan
        ;;
    start)
        load_config
        start
        ;;
    stop)
        stop
        ;;
    daemon)
        load_config
        daemon
        ;;
    weekly-report)
        load_config
        weekly_report
        ;;
    test-push)
        load_config
        test_push
        ;;
    stats)
        load_config
        stats
        ;;
    *)
        echo "用法: $0 {test|scan|start|stop|weekly-report|test-push|stats}"
        echo ""
        echo "命令:"
        echo "  test          - 测试 API 连接"
        echo "  scan          - 单次扫描"
        echo "  start         - 启动定时监控"
        echo "  stop          - 停止监控"
        echo "  weekly-report - 生成周报"
        echo "  test-push     - 测试 Telegram 推送"
        echo "  stats         - 显示统计"
        exit 1
        ;;
esac
