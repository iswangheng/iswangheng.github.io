# Learned Rules

从错误、反馈、观察中学到的规则。

---

## 2026-02-26

### Agent 设计原则

- **Files Over Databases** — 文件是人类和 Agent 都可读的，Git 可追踪
- **Playbooks Over Fine-Tuning** — 不微调模型，用运行时策略文件
- **Anti-Fragility** — 失败 → 记录 → 规则 → 下次避免

### AI Agent 行业洞察

- 自主性越高，安全披露越重要
- Browser Agent 风险最高（L4-L5 自主性 + 弱安全披露）
- MCP (Model Context Protocol) 是 Agent 互操作的事实标准
- 透明度是 Agent 的差异化竞争点
- Agent 从"辅助"到"自主"是 2026 主线趋势

### 自主性分级

- L1：用户主导，Agent 辅助
- L2：协作规划，共同执行
- L3：Agent 主导，用户批准关键步骤
- L4：Agent 自主执行，用户可干预
- L5：完全自主，用户仅观察

### 可靠性原则

- 5% 失败率 × 20 步 = 基本不可用
- 语义缓存可减少 70% API 调用

### 技术趋势

- 并行 Agent + 自我验证是 2026 配置
- Apple Xcode 26.3 正式支持 Agentic Coding
- 2026 是 Multi-Agent Systems 突破年

---

*此文件会持续更新*
