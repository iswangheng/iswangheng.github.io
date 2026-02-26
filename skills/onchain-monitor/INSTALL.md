# 安装指南

## 前置要求

- Node.js >= 18.0.0
- npm 或 yarn
- curl
- jq（JSON 处理）

## 步骤 1: 获取 API Keys

### 1.1 Etherscan API Key（免费）
1. 访问 https://etherscan.io/apis
2. 注册账户
3. 创建免费 API Key
4. 免费版限制：5 calls/second, 100,000 calls/day

### 1.2 Solscan API Key（免费）
1. 访问 https://solscan.io/api/v1/docs
2. 注册并获取 API Key
3. 免费版限制：根据官方文档

### 1.3 Telegram Bot Token
1. 在 Telegram 中找 @BotFather
2. 发送 `/newbot`
3. 按提示创建 bot
4. 保存返回的 token

### 1.4 Telegram Chat ID
1. 给你的 bot 发送一条消息
2. 访问：`https://api.telegram.org/bot<YOUR_BOT_TOKEN>/getUpdates`
3. 找到 `chat.id` 字段（目标 ID: 5958281885）

## 步骤 2: 配置

### 2.1 复制配置模板
```bash
cd /root/.openclaw/workspace/skills/onchain-monitor
cp data/config.example.json data/config.json
```

### 2.2 编辑配置
```bash
nano data/config.json
```

填入你的 API Keys：
```json
{
  "etherscan_api_key": "YOUR_KEY_HERE",
  "solscan_api_key": "YOUR_KEY_HERE",
  "telegram_bot_token": "YOUR_BOT_TOKEN",
  "telegram_chat_id": "5958281885",
  "min_transfer_usd": 50000,
  "smart_wallet_threshold": 0.7,
  "min_liquidity_usd": 100000,
  "scan_interval_minutes": 5,
  "tracking_intervals_hours": [1, 6, 24]
}
```

### 2.3 安装依赖
```bash
cd scripts
npm install
```

## 步骤 3: 测试

### 3.1 测试 API 连接
```bash
./scripts/monitor.sh test
```

预期输出：
```
✓ Etherscan API 连接成功
✓ Solscan API 连接成功
✓ Telegram 推送测试成功
✓ 所有系统正常
```

### 3.2 测试单次扫描
```bash
./scripts/monitor.sh scan
```

## 步骤 4: 配置 Cron（可选）

如需后台持续运行，配置 cron 任务：

```bash
# 编辑 crontab
crontab -e

# 添加以下行（每5分钟扫描一次）
*/5 * * * * /root/.openclaw/workspace/skills/onchain-monitor/scripts/monitor.sh scan >> /root/.openclaw/workspace/skills/onchain-monitor/data/cron.log 2>&1

# 每周一生成周报（周一 00:00）
0 0 * * 1 /root/.openclaw/workspace/skills/onchain-monitor/scripts/monitor.sh weekly-report >> /root/.openclaw/workspace/skills/onchain-monitor/data/cron.log 2>&1
```

## 步骤 5: 验证

### 5.1 检查日志
```bash
tail -f data/monitor.log
```

### 5.2 手动测试推送
```bash
./scripts/monitor.sh test-push
```

### 5.3 查看统计
```bash
./scripts/monitor.sh stats
```

## 常见问题

### Q: Etherscan API 返回 429 错误
A: 超过 rate limit，降低扫描频率或升级 API 计划

### Q: Telegram 推送失败
A: 检查：
1. Bot token 是否正确
2. Chat ID 是否正确
3. 是否先给 bot 发过消息

### Q: 找不到大额转账
A: 正常现象，大额转账不常见，可以临时降低阈值测试

### Q: Solscan API 连接失败
A: Solscan 免费版有时不稳定，建议重试或使用代理

## 升级

```bash
cd /root/.openclaw/workspace/skills/onchain-monitor
git pull  # 如果使用 git
npm update  # 更新依赖
```

## 卸载

```bash
# 停止 cron 任务
crontab -e  # 删除相关行

# 删除技能
rm -rf /root/.openclaw/workspace/skills/onchain-monitor
```
