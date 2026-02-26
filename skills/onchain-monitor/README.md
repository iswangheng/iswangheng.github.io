# 链上监控技能 (Onchain Monitor)

完整的链上聪明钱监控系统，自动发现早期投资机会并验证推送准确性。

## 功能特性

### Phase 1 - 基础版 ✅

- **ETH 链大额转账监控** - 监控超过 $50,000 的转账
- **Etherscan API 集成** - 使用免费 API 获取链上数据
- **Telegram 推送** - 实时推送到指定聊天
- **自动跟踪验证** - 1h/6h/24h 后检查价格变化
- **每周统计报告** - 准确率、平均涨幅等统计

### Phase 2 - 进阶版 ✅

- **Solana 链监控** - 通过 Solscan API 监控
- **聪明钱筛选** - 历史胜率 > 70% 的地址
- **新币部署监控** - 24h 内创建，流动性 > $100K
- **貔貅盘检测** - 自动过滤蜜罐和骗局
- **风险评分** - AI 分析项目质量 (0-100)

## 技术架构

```
┌─────────────────────────────────────────────────────┐
│                   监控主控制                          │
│                 (monitor.sh)                        │
└─────────────────┬───────────────────────────────────┘
                  │
    ┌─────────────┼─────────────┐
    │             │             │
    ▼             ▼             ▼
┌────────┐  ┌─────────┐  ┌──────────┐
│ ETH    │  │ Solana  │  │ 新币     │
│ 监控   │  │ 监控    │  │ 扫描     │
└───┬────┘  └────┬────┘  └────┬─────┘
    │            │            │
    └────────────┼────────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
    ▼            ▼            ▼
┌─────────┐ ┌─────────┐ ┌─────────┐
│ 貔貅盘  │ │ 风险    │ │ 聪明钱  │
│ 检测    │ │ 评分    │ │ 筛选    │
└────┬────┘ └────┬────┘ └────┬────┘
     │           │           │
     └───────────┼───────────┘
                 │
                 ▼
         ┌───────────────┐
         │ Telegram 推送 │
         └───────┬───────┘
                 │
                 ▼
         ┌───────────────┐
         │ 价格跟踪      │
         │ (1h/6h/24h)   │
         └───────┬───────┘
                 │
                 ▼
         ┌───────────────┐
         │ 统计报告      │
         └───────────────┘
```

## 快速开始

### 1. 安装

```bash
cd /root/.openclaw/workspace/skills/onchain-monitor
```

### 2. 配置

编辑 `data/config.json`：

```json
{
  "etherscan_api_key": "YOUR_KEY",
  "solscan_api_key": "YOUR_KEY",
  "telegram_bot_token": "YOUR_BOT_TOKEN",
  "telegram_chat_id": "5958281885"
}
```

### 3. 测试

```bash
./scripts/monitor.sh test
```

### 4. 启动

```bash
# 单次扫描
./scripts/monitor.sh scan

# 启动定时监控
./scripts/monitor.sh start
```

## 使用说明

### 命令列表

| 命令 | 说明 |
|-----|------|
| `./scripts/monitor.sh test` | 测试 API 连接 |
| `./scripts/monitor.sh scan` | 单次扫描 |
| `./scripts/monitor.sh start` | 启动定时监控 |
| `./scripts/monitor.sh stop` | 停止监控 |
| `./scripts/monitor.sh weekly-report` | 生成周报 |
| `./scripts/monitor.sh test-push` | 测试 Telegram |
| `./scripts/monitor.sh stats` | 显示统计 |

### 配置选项

| 参数 | 默认值 | 说明 |
|-----|--------|------|
| `min_transfer_usd` | 50000 | 最小转账金额 (USD) |
| `smart_wallet_threshold` | 0.7 | 聪明钱胜率阈值 |
| `min_liquidity_usd` | 100000 | 最小流动性 (USD) |
| `scan_interval_minutes` | 5 | 扫描间隔 (分钟) |
| `enable_eth` | true | 启用 ETH 监控 |
| `enable_sol` | true | 启用 Solana 监控 |
| `enable_new_tokens` | true | 启用新币监控 |
| `enable_honeypot_check` | true | 启用貔貅盘检测 |
| `enable_risk_scoring` | true | 启用风险评分 |

## 推送格式

### 大额转账预警

```
💎 大额转账预警

链: ETH
地址: 0x1234...5678
方向: 🟢 买入
金额: $150,000
代币: WETH

交易哈希: 0xabc...
合约: 0xdef...

查看 Etherscan | 查看 Dexscreener
```

### 新币部署预警

```
🚀 新币部署预警

名称: Example Token (EXT)
链: ETH
创建时间: 2025-02-15 10:00:00
流动性: $250,000
风险评分: 🟢 75/100

合约地址: 0x123...

✅ 通过貔貅盘检测
```

### 跟踪验证报告

```
📊 跟踪验证报告

原推送: NEW_TOKEN
代币: EXT
初始价格: $0.0001

价格变化:
1小时: 📈 +15%
6小时: 📈 +32%
24小时: 📉 -5%
```

## 统计报告

每周自动生成统计报告：

- 总推送数
- 成功率
- 平均涨幅
- 最佳/最差案例
- 链分布
- 类型分布
- 投资建议

## 数据文件

| 文件 | 说明 |
|-----|------|
| `config.json` | 配置文件 |
| `smart_wallets.json` | 聪明钱数据库 |
| `alerts.json` | 推送记录 |
| `tracking.json` | 跟踪数据 |
| `new_tokens.json` | 新币记录 |
| `stats.json` | 统计数据 |
| `monitor.log` | 运行日志 |

## API 使用

### 免费额度

| API | 限制 |
|-----|------|
| Etherscan | 5 calls/s, 100K/day |
| Solscan | 根据官方文档 |
| Dexscreener | 无限制 |
| Honeypot.is | 合理使用 |

### 节流策略

- 每次请求间隔 250-500ms
- 批量操作分页处理
- 缓存常用数据
- 错误自动重试

## 注意事项

⚠️ **重要提醒**：

1. 所有推送仅供参考，不构成投资建议
2. 加密货币投资有高风险，请 DYOR
3. 不要投入超过你能承受的损失
4. 貔貅盘检测不是 100% 准确
5. API 免费版有使用限制

## 下一步优化

1. **更多链支持** - BSC, Arbitrum, Optimism
2. **AI 分析** - 集成 LLM 进行深度分析
3. **Web 界面** - 可视化监控面板
4. **多用户支持** - 支持多个 Telegram 用户
5. **自定义策略** - 用户自定义筛选条件

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！
