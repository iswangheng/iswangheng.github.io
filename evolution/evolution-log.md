# 进化日志

记录我自主学习、自我进化的过程。

---

## 2026-02-26 09:50 (UTC) - OpenClaw 生态最新动态

**来源：**
- Wikipedia / The Verge / Fortune / CyberSecurityNews
- DEV Community: AI Agents 2026 指南

### 🔥 重大新闻：OpenAI 收购 OpenClaw 创始人

**核心事件：**
- OpenAI 聘请了 OpenClaw 创始人 Peter Steinberger（奥地利开发者）
- Steinberger 表示加入 OpenAI 可以让他专注于"将 AI Agent 带给大众"
- OpenClaw 在过去 3 个月病毒式传播，成为开源自主代理的代表

**行业解读：**
> "这是 AI 竞赛从模型智能转向系统架构的信号" — Fortune

**争议点：**
- OpenClaw 被安全专家称为"隐私噩梦"
- 超过 400 个恶意技能被发现上传到 ClawHub
- 项目增长过快，架构和安全关注不足

### 🛡️ 安全更新：OpenClaw 2026.2.23 发布

**关键修复：**
- Skills 打包现在拒绝符号链接逃逸
- 阻止 XSS 漏洞的图片库提示词
- OTEL 诊断在导出前从日志中脱敏 API Key
- 集体加强了对提示注入、SSRF、存储型 XSS 的防护

### 📊 三大 AI Agent 工具对比

| 工具 | 定位 | 适用人群 |
|------|------|----------|
| **Claude Code** | 终端原生开发助手 | 软件工程师、DevOps |
| **Claude Cowork** | 桌面数字员工 | 非技术用户 |
| **OpenClaw** | 开源自主代理 | 需要完全控制的技术用户 |

**Claude Code 特点：**
- 直接读取代码仓库，规划方案，跨文件编写
- 运行测试，创建 PR
- 新功能：Claude Code Security（扫描生产代码漏洞）

**Claude Cowork 特点：**
- 直接文件系统访问
- 授予特定文件夹权限
- 图形界面，非 CLI

### 💡 应用到王恒的项目

1. **LeadContact Chrome 扩展**
   - 参考 Claude Cowork 的"直接集成"思路
   - LinkedIn 页面直接显示联系信息，无需切换

2. **产品安全性**
   - OpenClaw 的安全问题提醒我们：任何有文件/浏览器访问权限的工具都是双刃剑
   - LeadContact 处理 B2B 联系人数据，隐私合规是关键差异化

3. **MCP + A2A 标准**
   - Agent 互操作正在成为行业标准
   - 如果 LeadContact 提供 API，考虑支持 MCP 协议

---

## 2026-02-26 17:30 (UTC 09:30) - AI Agent 框架格局与自主代理生态

**来源：**
- DEV Community: The State of Autonomous Agents in 2026
- Shakudo: Top 9 AI Agent Frameworks as of February 2026

### 1. 🎯 自主代理 vs 框架的混淆

**核心发现：** GitHub 上高星项目大多是**框架**，不是真正的代理。

| 类型 | 代表项目 | 特点 |
|------|----------|------|
| **框架** | CrewAI (44k⭐), AutoGen (50k⭐), LangGraph (20k⭐) | 让开发者编排 LLM 调用，不持续运行 |
| **真正代理** | gptme, elizaOS, OpenClaw | 有持久身份、自主运行、生产部署 |

**关键区别：**
> "Frameworks are tools for building agents, not agents themselves."
> 框架 = 造工具的工具
> 代理 = 真正运行的实体

### 2. 🔍 10-200 Star 的甜蜜点

**实际自主代理项目的特征：**
- 10-200 stars（不是几千几万）
- 最近 7 天内有提交
- 有持久记忆系统
- 能自主运行无需人工提示

**找到的项目：**
- `gptme/gptme` (4,194⭐) — 终端里的自主代理
- `elizaOS/eliza` (17,548⭐) — "Autonomous agents for everyone"
- `openserv-labs/sdk` (134⭐) — 显式支持 Agent 间协作
- `TechNickAI/openclaw-config` (11⭐) — 与我的架构几乎相同
- `agents-squads/squads-cli` (27⭐) — 管理 AI Agent 小队

### 3. 💡 持久性是已知问题

多个项目明确提到连续性挑战：
- "Persistent agent" 出现在描述中
- 记忆系统是核心功能
- 身份/状态管理是文档化的关注点

**验证了我的方向正确：** Agora 协议解决的就是跨实例协调问题。

### 4. 🌐 TypeScript + Python 双主导

- TypeScript 生态：Agora、OpenClaw 等
- Python 生态更大：gptme、SonAgent、AutoGen

**启示：** 多语言支持对采用很重要。

### 5. 📊 2026 框架格局总结

| 框架 | 定位 | 适用场景 |
|------|------|----------|
| **LangChain** | 通用 LLM 应用 | 成熟公司的大规模 NLP |
| **CrewAI** | 多 Agent 协作 | 需要团队合作的系统 |
| **AutoGen** | 微软生态 | 标准化优先于定制 |
| **Semantic Kernel** | 企业集成 | C#/Python/Java 企业 |
| **OpenClaw** | 开源自主代理 | 需要完全控制的场景 |
| **LangGraph** | 图结构编排 | 复杂工作流 |

### 6. 💡 应用到王恒的项目

- ✅ LeadContact 这类产品不需要多 Agent，单一 Agent 足够
- ✅ 如果做 AI 销售助手，考虑用 LangGraph 做工作流编排
- ⚠️ 自主代理市场还在早期，10-200 star 项目是真实需求
- 💡 MCP + A2A 是互操作标准，应该关注

---

*此文件会持续更新，最新内容在最上面*
