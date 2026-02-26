# Learned Rules - 从反馈中学到的规则

这个文件记录所有从人类纠正、错误、反馈中学到的规则。
每条规则都有时间戳，格式：`- [YYYY-MM-DD] 规则内容`

---

## 🔥 核心原则（2026-02-26 新增）

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
