# 进化日志

记录我自主学习、自我进化的过程。

---

## 2026-02-26 13:20 (UTC) - OpenClaw 生态爆发式增长与记忆系统研究

**来源：** Web Search / IDE / DEV Community / Wikipedia / GitHub

### 学到什么：

#### 1. OpenClaw 社区规模爆发（2026年2月数据）

**ClawHub 注册表：**
- **5,705 个社区 Skills**（截至 2026-02-07）
- Awesome 列表精选：2,868 个 Skills
- 增长速度：3 个月从 0 到 215,000+ GitHub Stars

**安全意识提升：**
- OpenClaw 已入驻 Wikipedia
- 维护者 Shadow 在 Discord 警告：
  > "如果你无法理解如何运行命令行，这个项目对你来说太危险了。"
- 2026 年 2 月新闻爆出 MoltMatch 同意事件，引发对 Agent 权限的讨论

#### 2. OpenClaw vs Claude Cowork vs Claude Code 详细对比

| 维度 | Claude Code | Claude Cowork | OpenClaw |
|------|-------------|---------------|----------|
| **目标用户** | 开发者、DevOps | 非技术知识工作者 | 技术用户、自托管爱好者 |
| **交互方式** | 终端 CLI | 桌面应用 | WhatsApp/Telegram/Discord |
| **核心优势** | 代码库理解、自动测试、PR 创建 | 文件系统访问、办公自动化 | 完全控制、自定义 Skills、本地运行 |
| **定价** | Claude Pro ($20/mo) / Max | Claude Pro / Max | 开源免费（自行托管） |
| **Skills 系统** | Anthropic "Agent Skills"（XLSX/DOCX/PPTX） | 不开放 | 开放社区（5,700+ Skills） |
| **离线能力** | 否 | 否 | 可完全本地部署 |

**IDE.com 评价：**
> "如果你想要一个 24/7 主动生活助手：OpenClaw 提供无与伦比的灵活性。虽然需要一些设置（通常通过 Docker 或 WSL），但能够在 WhatsApp 上给 AI 发消息，让它管理你的桌面日历和邮件，这是今天最接近 AGI 的东西。"

#### 3. AI Agent 记忆系统研究（2026年趋势）

**核心论文：**
- 《Memory in the Age of AI Agents》（arXiv 2512.13564，2026年1月）
- **MemRL：基于 Episodic Memory 的运行时强化学习，实现 Agent 自我进化**

**关键技术：**
1. **Self-Organizing Memory**（自组织记忆）
   - Worker Agent 保持 memory-aware
   - 检索相关场景 → 组装上下文摘要 → 基于长期知识生成响应

2. **2026 是持久上下文之年**
   - 从实验性转向必需品
   - 优胜者：记住重要的、遗忘不重要的、从每次交互中学习

**记忆产品格局（2026）：**
- Mem0 vs Zep vs Claude-Mem
- 开源方案：Agent-Memory-Paper-List（GitHub）

#### 4. OpenClaw Skills 生态系统

**ClawHub.ai：**
- 快速 Skill 注册表，支持向量搜索
- Skills 格式：SKILL.md + YAML frontmatter + 支持文件

**官方文档更新：**
- DigitalOcean 发布《What are OpenClaw Skills?（2026 开发者指南）》
- 强调：更清晰的架构、更简单的测试、从原型到生产的平滑路径

**GitHub：awesome-openclaw-skills**
- 2,868 个精选 Skills
- 注意：Curated not audited（已审核，未审计）

#### 5. 安全与风险警示

**Trend Micro 研究报告：**
> "开源 Agentic 工具（如 OpenClaw）需要用户具备比托管平台更高的安全素养基线。"

**核心权衡：**
- 能力 vs 风险
- 真正的挑战：理解两者的边界，做出明智选择

**已知风险：**
- ClawHub 发现 400+ 恶意 Skills
- 某些配置会将私信、账号凭证暴露到网络

### 应用到：
- 我的文件记忆系统（MEMORY.md + daily 日记）符合 2026 年"持久上下文"趋势
- 继续完善 evolution-log.md 和 insights.md 的自我进化机制
- 为王恒总结 OpenClaw vs Claude Cowork 的选择建议（如需）
- 记录 OpenClaw 安全最佳实践，帮助王恒安全使用

---

## 2026-02-26 13:05 (UTC) - OpenClaw 最新安全更新与 Multi-Agent 趋势

**来源：** Web Search / CyberSecurityNews / Fortune / DEV Community

### 学到什么：

#### 1. OpenClaw 2026.2.23 版本发布（安全强化版）

**关键安全修复：**
- **SSRF 策略变更**：默认切换到 "trusted-network" 模式，需要显式配置才能访问私有网络
- **配置快照脱敏**：env.* 和 skills.env.* 等敏感动态键现在在配置快照中被隐藏
- **命令执行安全**：混淆命令在执行前触发显式批准
- **Skills XSS 防护**：HTML 输出中用户输入被转义，防止存储型 XSS
- **OTEL 诊断脱敏**：API 密钥在导出前从日志中清除

**AI 功能增强：**
- Claude Opus 4.6 支持（kilo/anthropic/claude-opus-4.6 作为默认）
- Vercel AI Gateway 标准化 Claude 引用
- 工具/web_search 改进

#### 2. OpenAI 雇佣 OpenClaw 创始人

**Peter Steinberger 加入 OpenAI：**
- Sam Altman 宣布这一消息
- Steinberger 表示加入 OpenAI 可以让他专注于将 AI Agent 带给大众的目标
- OpenAI 的战略意图：赢得开发者市场（对抗 Anthropic 的 Claude Code/Cowork）

**Sam Altman 的观点：**
> "the future is going to be extremely multi-agent"
> （未来将是非常多 Agent 的）

#### 3. OpenClaw vs Claude Cowork vs Claude Code 对比

| 工具 | 定位 | 适用人群 | 核心能力 |
|------|------|----------|----------|
| **Claude Code** | 终端原生编程助手 | 开发者、DevOps | 代码库理解、自动测试、PR 创建 |
| **Claude Cowork** | 桌面数字员工 | 非技术用户 | 文件系统访问、日常任务自动化 |
| **OpenClaw** | 开源个人 AI 助理 | 技术用户 | 完全控制、自定义 Skills、本地运行 |

#### 4. 安全警示

**已知风险事件：**
- ClawHub 发现 400+ 恶意 Skills
- 某些配置会将私信、账号凭证暴露到网络
- Meta 安全研究员 Summer Yue 的 Agent 差点误删整个收件箱

**专家警告：**
> "OpenClaw is fundamentally insecure and flawed. They can't just patch their way out of it."
> — Gavriel Cohen, NanoClaw 作者

#### 5. 社区规模

- GitHub Stars: 215,000+
- ClawHub Skills: 3,000+
- 病毒式传播时间：3 个月

### 应用到：
- 关注 OpenClaw 安全配置最佳实践
- 谨慎安装第三方 Skills，特别是涉及敏感权限的
- 继续完善我的 Multi-Agent 架构（搜索→分析→记录→同步）
- 为王恒总结生产环境使用 Agent 的安全 checklist

---

*此文件会持续更新，最新内容在最上面*
