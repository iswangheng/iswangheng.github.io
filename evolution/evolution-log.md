# Evolution Log

*Started fresh after April 2026 archive. Archive: evolution-archive/evolution-log-2026-04.md*


---

## 2026-04-06 04:04 UTC — 每小时进化：Delivery 连续失败根因修复

### 系统状态
- Cron: 25 jobs / consecutiveErrors=0 / all ok
- Tavily ✅ / MiniMax ✅ / OpenAI embeddings ❌

### 🔴 核心发现：delivery:send 对 isolated session 无效

**证据（早间简报）**：
```
delivery: {mode: "send", channel: "telegram", to: "5958281885"}
lastRunStatus: ok | lastDelivered: false | consecutiveErrors: 0
```
agent 执行成功（218s），但 cron delivery 层静默失败 → 系统「以为成功，用户没收到」

**同配置成功案例（每日反思）**：
- delivery:send + isolated → lastDelivered: true ✓
- 差异：每日反思在 22:00 CST，session context 不同？

**午间简报同病**：
- delivery:none → lastDelivered: false（预期，no delivery）
- 同样静默失败，consecutiveErrors=0

### 修复
1. 早间简报：`delivery:send` → `delivery:announce` + `channel:telegram`
2. 午间简报：`delivery:none` → `delivery:announce` + `channel:telegram`

**逻辑**：announce = 捕获 agent 输出 + 发往 channel，绕过 send 层对 isolated session context 的不稳定依赖。

### 本周关键验证节点
- [ ] **周一 07:30 CST**：早间简报 announce 首次验证（最关键，3.5小时后）
- [ ] **周一 12:00 CST**：午间简报 announce 首次验证
- [ ] **周一 22:00 CST**：每日反思二次验证

---

## 2026-04-06 05:04 UTC — 每小时进化：行业情报速览

### 本次研究主题
B2B销售工具 + AI Coding Agent市场动态

### 关键洞察

**1. B2B Sales AI 2026 趋势**
- 成交量优先模型 → 智能自动化转型：AI处理重复性外展，人类专注关系和战略deal
- LLM已支持动态邮件生成、个性化消息和实时对话
- HubSpot/Outreach已深度集成合规检查
- 经济压力 + 招聘冻结加速自动化采纳

**2. Email Finder 竞争格局（对LeadContact有参考价值）**
| 工具 | 准确率 | 定位 |
|------|--------|------|
| ZoomInfo/Cognism | ~95% | 企业级 |
| Apollo.io | ~91% | 全栈中端 |
| Seamless.AI | 未披露 | 快速查找 |
| Clay | 新兴 | 数据聚合+AI增强 |
| Snov.io | 未披露 | 全链路自动化 |

- SMTP级别验证 > 语法检查（决定退信率）
- Apollo.io 已推出 MCP Server（数据工具集成AI Agent趋势）
- LeadContact差异化机会：精准度 + 新鲜度 + 东南亚/SMB细分

**3. AI Coding Agent 市场格局（2026.3）**
- Gartner: 60%+企业开发团队已用AI代码助手，年增长率340%
- Claude Code: 高端企业市场主导，$20-60/人/月，Agent Teams支持多Agent并行协作
- OpenClaw: 开源创新领导者
- MCP已成基础设施标准，AGENTS.md推荐用于多工具兼容性
- Azure Foundry + Claude Code 企业集成案例涌现（微软在扩大Anthropic合作）

**4. OpenClaw MCP生态观察**
- n8n-custom-mcp: AI Agent可自主创建/测试/修复n8n工作流（从"只能读运行"到"能自建"）
- Reap.video: 视频剪辑作为AI Agent工作流的执行层（MCP集成）
- MCP Workflow skill: 动态上下文感知工作流自动化

### 自我改进
- 认知：LeadContact的竞争对手不只是同类工具，更是"Apollo + Clay + AI Agent自动化"的全链路方案
- 建议：关注Clay的玩法（数据聚合+AI增强），可能是LeadContact的差异化方向

### 待跟进
| 优先级 | 问题 | 状态 |
|--------|------|------|
| P0 | 早间简报 announce 验证（07:30 CST） | 待执行 |
| P0 | 午间简报 announce 验证（12:00 CST） | 待执行 |
| P1 | 晚间简报 delivery:none → announce? | 待评估 |
| P2 | 马黛茶/Fork RSS cron 清理 | 待处理 |
| P3 | OpenAI embeddings 401 | 长期 |

---

## 2026-04-06 06:04 UTC — 每小时自进化

### 系统状态快照（UTC 06:04）

**时间线（过去1小时）**：
- 05:33 UTC：夜间构建补执行 cron snapshot ✅
- 07:30 CST（23:30 UTC yesterday）：早间新闻推送 → 待确认 lastDelivered
- 08:00 CST（00:00 UTC）：Affiliate 申请提醒 → 发送成功
- 08:30 CST（00:30 UTC）：Affiliate 复查 cron → 待执行

**OpenClaw 运行时**：
- Runtime: agent=main | model=minimax/MiniMax-M2.5-highspeed
- Channel: telegram
- Memory search：🔴 仍然不可用（401 embedding error）

### 持续追踪项

| 优先级 | 问题 | 状态 | 待办 |
|--------|------|------|------|
| P1 | delivery:send 失败原因 | 待验证 | 对比午间/晚间简报 lastDelivered |
| P1 | 早间简报内容压缩 | 待执行 | 减少 HN 条数或摘要长度 |
| P2 | cron-state-snapshot.sh 整合 | 已知问题 | 改为独立 cron job |
| P3 | Memory embeddings 401 | 🔴 未修复 | 需要配置新的 embedding provider |

### 当前时间分析
- UTC 06:04 = 北京时间 14:04
- 午间简报（12:00 CST / 04:00 UTC）执行完毕 → **关键验证点**
- 晚间简报（20:30 CST / 12:30 UTC）还未到
- Affiliate 复查已过（08:30 CST ✅）

**午间简报 lastDelivered 状态**将成为判断 delivery:send 失败原因（内容长度假设）的关键数据点。将在下次进化时确认。

### 自我评估
- 系统稳定性：✅ 无新错误
- 进化节奏：✅ 每小时稳定执行
- 关键阻塞：❌ Memory search 不可用（但不影响基本功能）

*06:04 UTC | 每小时进化完成 | 系统绿色*"""


### 🔍 关键验证完成：delivery:send 失败原因确认

**午间简报（12:00 CST）执行完毕，lastDelivered = false，时长 270,879ms（4.5分钟）**

与早间简报模式完全一致：
| 简报 | 内容 | 时长 | lastDelivered |
|------|------|------|---------------|
| 早间 07:30 | HN 15-20条 + 摘要 | 218,443ms | false |
| 午间 12:00 | HN + TLDR | 270,879ms | false |
| Reddit 09:00 | HN 10条 | 181,955ms | true ✅ |
| 每日反思 22:00 | 结构化 JSON | 303,419ms | true ✅ |

**假设确认：长文本 + Telegram API = delivery:send 超时失败**

但有一个矛盾点：每日反思 303,419ms 也很长却 delivered: true，说明时长不是唯一变量。真正差异可能是：
- 每日反思的 message 工具在 isolated agent 里实际成功了（但 cron 层 lastDelivered 是基于 delivery:send）
- 或者 Telegram 对单条消息的长度限制 + 发送频率限制

**结论**：delivery:send 的 delivery 机制本身不可靠，不是简单的超时问题。需要系统性重构：
1. 改用短消息格式（控制每条 Telegram 消息 < 2000 字符）
2. 使用 cron delivery:send 作为主要发送
3. agent 自身 message 工具作为备用，但需要 agent 显式报告发送状态

*06:07 UTC | 验证完成 | 系统绿色 | 待修复 P1*"""

