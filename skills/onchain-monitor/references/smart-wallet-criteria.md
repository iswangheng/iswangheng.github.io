# 聪明钱筛选标准

## 概述

聪明钱（Smart Money）是指历史上表现优异的钱包地址。本技能通过多维度分析筛选出值得跟踪的地址。

## 筛选标准

### 核心指标

#### 1. 历史胜率 > 70%

- 计算方法：(盈利交易数 / 总交易数) × 100%
- 最低要求：70%
- 理想值：80%+

#### 2. 平均持仓时间

- 短期交易者：< 24 小时
- 中期持有者：1-7 天
- 长期投资者：> 7 天
- 偏好：中期持有者（降低噪音）

#### 3. 交易频率

- 活跃交易者：> 50 笔/月
- 中等活跃：10-50 笔/月
- 低频交易：< 10 笔/月
- 偏好：中等活跃（平衡信息量和质量）

#### 4. 资金规模

- 大户：> 100 ETH 等值
- 中等：10-100 ETH
- 小户：< 10 ETH
- 偏好：中等以上（更有参考价值）

### 排除标准

自动排除以下类型的地址：

1. **交易所地址** - CEX 热钱包、冷钱包
2. **合约地址** - 除非是知名协议
3. **MEV 机器人** - 高频套利地址
4. **内幕交易嫌疑** - 时间点过于精准
5. **拉高出货** - 历史上有操纵嫌疑

## 聪明钱分类

### A 类：顶级聪明钱

- 胜率 > 80%
- 历史记录 > 50 笔
- 平均收益 > 50%
- 标签：**🔥 必须关注**

### B 类：优质聪明钱

- 胜率 > 70%
- 历史记录 > 30 笔
- 平均收益 > 30%
- 标签：**⭐ 值得关注**

### C 类：潜力聪明钱

- 胜率 > 65%
- 历史记录 > 20 笔
- 平均收益 > 20%
- 标签：**👀 观察中**

## 跟踪策略

### 新发现的钱包

1. 先进入观察列表（C 类）
2. 跟踪 30 天
3. 根据表现升级或降级

### 已跟踪的钱包

1. 每周更新表现数据
2. 胜率下降 > 10% 降级
3. 连续 3 次亏损警告
4. 连续 5 次亏损移除

## 推送优先级

当检测到聪明钱活动时：

1. **A 类钱包** - 立即推送，所有活动
2. **B 类钱包** - 立即推送，大额活动（> $10K）
3. **C 类钱包** - 延迟推送（15分钟），仅大额活动

## 评分公式

```
SmartScore = (WinRate × 40) + (ProfitFactor × 30) + (Consistency × 20) + (TrustScore × 10)

其中：
- WinRate: 胜率 0-100
- ProfitFactor: 平均盈利/平均亏损
- Consistency: 最近10笔交易的稳定性
- TrustScore: 地址年龄、交易量等信任指标
```

## 实现细节

### 数据收集

```javascript
async function analyzeWallet(address, chain) {
    const transactions = await getTransactions(address, chain, 100);
    
    let wins = 0, losses = 0;
    let totalPnl = 0;
    
    for (const tx of transactions) {
        const pnl = calculatePnL(tx);
        if (pnl > 0) wins++;
        else losses++;
        totalPnl += pnl;
    }
    
    const winRate = wins / (wins + losses);
    const avgPnl = totalPnl / transactions.length;
    
    return {
        address,
        winRate,
        avgPnl,
        totalTrades: transactions.length,
        isSmart: winRate >= 0.7 && avgPnl > 0
    };
}
```

### 自动更新

```bash
# Cron: 每天凌晨更新聪明钱数据
0 0 * * * node smart-wallet.js update
```

## 注意事项

1. **不要盲目跟单** - 聪明钱也可能出错
2. **注意时间差** - 推送时可能已经错过最佳入场点
3. **考虑滑点** - 大额交易可能影响价格
4. **分散风险** - 不要只跟踪一个地址

## 已知聪明钱来源

可以从以下渠道发现聪明钱：

1. **链上分析工具** - Nansen, Arkham
2. **社交媒体** - Twitter, Telegram
3. **社区分享** - Discord, 论坛
4. **自动发现** - 大额盈利交易反查

## 维护建议

1. 定期清理表现下降的地址
2. 持续发现新的聪明钱
3. 记录推送准确率
4. 优化筛选参数
