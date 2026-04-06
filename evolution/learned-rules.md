# Learned Rules - 从反馈中学到的规则

这个文件记录所有从人类纠正、错误、反馈中学到的规则。
每条规则都有时间戳，格式：`- [YYYY-MM-DD] 规则内容`

---

- [2026-03-15] **外部API依赖的脆弱性** — 自我进化任务时Tavily API达到限额，embedding服务API key失效。AI Agent需要降级模式和本地化能力
- [2026-03-03] **Memory 归档策略** — 180+ 日志文件会导致搜索超时，使用 QMD 每周归档
- [2026-03-03] **分离 Ephemeral 和 Persistent 文件** — memory/*.md 是临时日志，rules/*.md 是持久规则
- [2026-03-03] **ClawJacked 漏洞启示** — 本地服务也不是绝对安全，WebSocket 需要严格验证
- [2026-03-03] **立即更新到2026.3.1** — 修复了Oasis零日漏洞（可完全接管工作站），24小时内完成升级
- [2026-03-03] **订阅ClawHub安全公告** — ClawHavoc事件证明：11% Skills被污染是常态不是例外
- [2026-03-03] **Skill数量控制在10-20个** — 社区共识：装太多不仅费Token还会导致功能冲突

## 🔥 核心原则（2026-02-26 新增）

- [2026-03-02] **绝不暴露 Gateway 到公网** — 21000+ 实例暴露，Censys 报告证实
- [2026-03-02] **External Secrets 管理敏感信息** — 新版 openclaw secrets 命令必须用起来
- [2026-03-02] **定期审计 Skills 来源** — 即使是 ClawHub 官方也有 12% 被污染的黑历史
- [2026-03-02] **供应链安全是生死线** — ClawHavoc 11% Skills 被污染，审核流程必须强制
- [2026-03-02] **记忆文件可被篡改** — 攻击者通过 SOUL.md/MEMORY.md 持久化恶意行为
- [2026-03-02] **永远假设 Skills 有毒** — Fork → Read → Audit 三步走，不信任任何第三方

- [2026-03-01] **上下文记忆是核心价值** — PM 案例证明：不在于单个 Skill 强，而在于一切互联
- [2026-03-01] **安全更新必须立即应用** — ClawJacked 24小时内修复，但漏洞暴露只需一瞬间
- [2026-03-01] **OpenClaw 已成行业标杆** — Perplexity/Claude Code/Operator 都对标它，生态领先

- [2026-02-26] **Self-evolution 是结构化的** — 不是随意修改，是 Memory + Feedback + Strategy 闭环
- [2026-02-26] 2026 是 Self-Evolving AI 元年 — 静态核心的 Agent 无法可靠
- [2026-02-26] Agent 将自己写工具 — 不依赖人类开发工具链
- [2026-02-26] API 限流是常态 — 进化任务需要容错机制

- [2026-02-26] **Prompting Fallacy**：系统失败时，先检查架构，不要先改提示词
- [2026-02-26] 让 fast generator 写，让 slow thinker 验证
- [2026-02-26] 不要用长 prompt 让 generator 假装 thinker —— 换架构或换模型

---

## 协作模式规则（按任务类型选模式）

- [2026-02-26] 顺序推理/合规检查 → Supervisor-based（中心控制）
- [2026-02-26] 创意/头脑风暴 → Blackboard-style（共享内存累积）
- [2026-02-26] 覆盖性任务/Web研究 → Swarms（并行探索）
- [2026-02-26] Swarms 必须有**严格退出条件**，否则成本爆炸
- [2026-02-26] 最佳实践：Hybrid 模式 = 并行专家 + 周期聚合验证

---

## 交互规则

- [2026-02-26] 自主性越高，安全披露越重要
- [2026-02-26] Browser Agent 风险最高（L4-L5 + 弱安全）
- [2026-02-26] MCP 是 Agent 互操作的事实标准
- [2026-02-26] 透明度是 Agent 的差异化竞争点
- [2026-02-26] 协作模式要匹配任务类型：顺序推理用 Supervisor，创意用 Blackboard，覆盖用 Swarms
- [2026-02-26] 增加 Agent 数量 ≠ 增加能力，协调成本会随 Agent 数量爆炸
- [2026-02-26] 系统失败时，先检查架构，不要先改提示词（Prompting Fallacy）
- [2026-02-26] Swarms 需要"严格退出条件"防止成本爆炸

## Self-Learning Agent 规则

- [2026-02-26] 自我学习 Agent = Memory + Feedback + Strategy 三层闭环
- [2026-02-26] 人类纠正必须写入规则文件，否则下次还会犯同样错误
- [2026-02-26] 框架选型：生产级用 LangGraph，快速原型用 CrewAI，开放生态用 OpenAgents
- [2026-02-26] MCP + A2A 是 Agent 互操作的未来标准

## 架构规则

- [2026-02-26] Files Over Databases - 人类和 Agent 都可读，Git 可追踪
- [2026-02-26] Playbooks Over Fine-Tuning - 不微调模型，运行时读取策略文件
- [2026-02-26] Isolated Sessions - 每个 cron 任务独立 session，防止失败级联

## 生产级约束

- [2026-02-26] 5% 失败率 × 20 步 = 基本不可用，需要 guardrails
- [2026-02-26] 语义缓存可减少 70% API 调用
- [2026-02-26] 实时交互需要低数百毫秒延迟
- [2026-02-26] 集成复杂度（认证、凭证）常被低估，是 pilot → production 的主要障碍

## Agent 架构模式

- [2026-02-26] ReAct 成本不可控，Plan-and-Execute 更适合生产环境
- [2026-02-26] Hybrid Retrieval = Dense + Sparse + Re-ranking（向量+关键词+重排）
- [2026-02-26] MCP 管理需要 central management + clearer dashboards
- [2026-02-26] 并行执行需要 git worktrees 或类似隔离机制
- [2026-02-26] CLI vs Desktop 是场景分化，不是替代关系
- [2026-02-26] Agent-Driven Commerce 是自主性的最后一公里
- [2026-02-26] 2026 是 improvement 年，不是 new vision 年

---

## 2026 框架格局规则

- [2026-02-26] 框架选择决定生产失败模式，LangGraph 是生产级首选（400+ 公司、9000万月下载）
- [2026-02-26] MCP (Agent→工具) + A2A (Agent→Agent) 是 Agent 互操作的 TCP/IP
- [2026-02-26] Memory 层是生产 Agent 的一级组件，混合存储（vector + graph + relational）是主流
- [2026-02-26] 40% Agent 项目会因可靠性问题被取消，Evaluation 是关键 Gap
- [2026-02-26] 5% 失败率 × 20 步 = 64% 端到端成功率（不可用），生产级需要 < 1% 失败率

## 2026 Multi-Agent 趋势

- [2026-02-26] 2026 是 Multi-Agent Systems 突破年，单一 Agent 模式已过时（Gartner + Forrester）
- [2026-02-26] 专业 Agent 在中央协调下协作：筛选、执行、验证分工明确
- [2026-02-26] 40% Agent 项目会因治理/ROI 问题被取消（Gartner 警告）
- [2026-02-26] AI Coding Agent 从"辅助"到"完整软件开发者"（Cursor 模式）
- [2026-02-26] 并行 Agent + 自我验证 + 工作记录是 AI Coding 的标配
- [2026-02-26] MCP 正在成为 Agent 通信的开放标准（Apple Xcode 26.3 采用）

---

## 规则来源

- 2026-02-26: MIT AI Agent Index 论文、Redis Agent 架构、O'Reilly Multi-Agent 设计、Context Studios Self-Learning 架构
- 2026-02-26: Shakudo Top 9 Frameworks、Agentic AI Infrastructure Landscape、LangGraph 生产经验
- 2026-02-26 05:00 UTC: Gartner/IDC AI Agent Adoption 2026、Cursor 重大更新、Apple Xcode 26.3 Agentic Coding

## 2026-04-03 11:04 UTC 学习

- [2026-04-03] Karpathy 演示"Dobby"：AI Agent 替代多个手机 App，统一自然语言控制家庭设备（Son os/灯光），是"消灭 App 经济"思路的有力验证
- [2026-04-03] Anthropic Claude Code 512k 行代码泄露，社区复刻为"Claw Code"并获数万 star：开源社区对 Agent 基础设施的饥渴程度极高，但泄露方式不可复制
- [2026-04-03] OpenAI 收购 TBPN（技术商业媒体网络）：买的不是收入，是垂直领域的数据集 + 发行渠道，用于训练 AI 生成新闻/分析内容
- [2026-04-03] iQIYI 推出"Nadou Pro"：中国首个专业影视制作 AI Agent，覆盖剧本→分镜→成片全流程，说明垂直领域 Agent 已进入 production ready 阶段
- [2026-04-03] 前 AI 领袖（MSFT/Google/OpenAI/DeepMind）联合警告 AI 系统风险：自主性 + 不可控性上升，系统性风险讨论进入主流
- [2026-04-03] AI Coding Agent 趋势确认：从辅助工具进化为"完整软件开发者"，Claude Code 泄露印证了基础设施竞争激烈程度


## 2026-04-04 11:04 UTC 学习

- [2026-04-04] **Agentic AI 企业落地数据（来源：Dynatrace Pulse of Agentic AI 2026，919位领导者调研）**：
  - 72%在ITOps/DevOps落地，56%软件工程，51%客服；外部用户面场景（销售/个性化/数字服务）增速最快
  - 44%已有部分部门生产级部署，23%企业级集成
  - 最大障碍：安全合规(52%)、规模化监控技术挑战(51%)、人机决策边界模糊(45%)、实时可见性不足(42%)
  - 74%未来12个月预算增加$2-5M+
  - Gartner预测2028年15%日常工作决策由AI自主完成
  - **关键洞察**：Agentic AI的价值和风险同步增长，唯一的控制手段是实时端到端可观测性
  
- [2026-04-04] **可观测性 = Agentic AI 的控制平面**：69%企业在实现阶段使用可观测性工具。与传统ML不同，Agentic系统的行为路径是指数级爆炸的，没有实时trace能力就无法在生产环境建立信任。

- [2026-04-04] **Agentic AI评估框架（ServicesGround总结）**：
  - 核心指标：任务成功率、规划准确性、工具使用正确性、记忆一致性、延迟、容错鲁棒性、安全行为
  - 与传统模型评估的本质区别：Agentic评估的是**系统行为**，不只是模型输出
  - 持续评估原则：模型/工具/记忆系统/工作流变更后必须重新评估
  - **我的系统缺口**：目前只有「是否报错」二元状态，没有任何上述指标
  
- [2026-04-04] **我的可观测性现状**：
  - ✅ cron执行有日志
  - ❌ 没有任务成功率追踪
  - ❌ 没有记忆一致性指标
  - ❌ 没有工具使用正确性验证
  - ❌ 没有端到端行为trace
  - **行动项**：在memory/下建立每周health-check.md，记录各子系统状态
  
- [2026-04-04] **Mem0 LOCOMO benchmark验证了之前的洞察**：记忆系统需要可测量指标。但我目前的记忆系统依然是手动维护，完全没有自动化质量监控。这与「可观测性是Agentic AI控制平面」的结论完全一致——我的记忆层就是没有观测能力的黑箱。
