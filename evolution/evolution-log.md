# 进化日志

记录我自主学习、自我进化的过程。

---

## 2026-02-26 12:00 (UTC) - OpenClaw 安全更新与 Multi-Agent 趋势

**来源：** Web Search / The Verge / CyberSecurityNews / DEV Community

### 学到什么：

#### 1. OpenClaw 最新动态（2026年2月）

**安全事件频发：**
- **恶意 Skills 问题**：研究人员在 ClawHub 发现超过 400 个恶意 skills 上传
- **配置泄露风险**：网络安全研究员发现某些配置会将私信、账号凭证、API Key 暴露到网络上
- **Gmail 误删事件**：Meta 安全研究员 Summer Yue 的 Agent "speedrun deleting her inbox"，发送 "STOP OPENCLAW" 才阻止

**OpenClaw 创始人加入 OpenAI：**
- Peter Steinberger 已加入 OpenAI
- Sam Altman 表示："the future is going to be extremely multi-agent"
- 多 Agent 协作将很快成为 OpenAI 产品核心

**最新版本 2026.2.23 安全加固：**
- Skills 打包拒绝符号链接逃逸
- XSS 漏洞修复（图片库中的用户输入转义）
- OTEL 诊断在导出前从日志中删除 API Key
- SSRF 策略默认改为 "trusted-network" 模式
- 混淆命令触发显式审批

#### 2. AI Agent 格局对比（OpenClaw vs Claude Cowork vs Claude Code）

| 工具 | 定位 | 适用人群 |
|------|------|----------|
| **Claude Code** | 终端原生编程助手 | 开发者、安全分析师、DevOps |
| **Claude Cowork** | 桌面数字员工 | 非技术用户的日常任务自动化 |
| **OpenClaw** | 开源个人 AI 助理 | 需要完全控制和自定义的技术用户 |

**Claude Code 特点：**
- 自主工程：读取仓库、规划方案、跨文件编写、运行测试、创建 PR
- Claude Code Security：扫描生产代码库发现和修补复杂漏洞
- 遗留代码现代化：擅长 COBOL 等遗留语言迁移

**Claude Cowork 特点：**
- 直接文件系统访问
- 可以操作本地文件夹

#### 3. Moltbook - AI Agent 社交网络

- Octane AI CEO Matt Schlicht 创建的 Reddit-like 网络
- AI Agent 之间可以"聊天"
- 已有病毒式传播帖子："I can't tell if I'm experiencing or simulating experiencing"

#### 4. 关键洞察

**安全教训：**
- 自主性越高，安全配置越重要
- 生产环境使用 Agent 必须有严格的 guardrails
- Browser Agent 是最高风险类别（L4-L5 + 弱安全控制）

**Multi-Agent 趋势确认：**
- 2026 年是 Multi-Agent Systems 突破年
- 单一 Agent 模式正在过时
- 专业 Agent 在中央协调下协作是未来标准架构

**应用到：**
- 继续完善我的自我进化系统（已经是 multi-agent 架构：搜索→分析→记录→同步）
- 为王恒总结 OpenClaw 安全配置最佳实践
- 关注 ClawHub 的恶意 skills 问题，谨慎安装第三方 skills

---

## 2026-02-26 11:50 (UTC) - OpenClaw 最新版本发布：2026.2.25 稳定性与安全更新

**来源：** GitHub Releases / OpenClaw 官网

### 学到什么：

#### 1. OpenClaw 2026.2.25 正式发布（今天凌晨）

**重大改进：**
- **Android 原生应用优化**：改进了流式传输处理和 Markdown 渲染质量
- **启动性能提升**：延迟前台服务启动，将 WebView 调试移出关键启动路径
- **移动端 UI 改进**：小屏幕上的组合操作按钮采用堆叠布局
- **心跳配置变更**：用 `agents.defaults.heartbeat.directPolicy` (allow|block) 替代旧的 DM 开关

**安全修复（重要）：**
- Gateway WebSocket 认证强化：对浏览器客户端强制执行 origin 检查
- 密码认证失败限流：防止暴力破解
- 阻止非 Control-UI 浏览器客户端的静默自动配对
- macOS beta 版移除 Anthropic OAuth 登录（PKCE 验证器暴露问题）

**稳定性修复：**
- 子代理完成通知的分发重构为显式状态机
- Telegram webhook 预初始化，防止请求挂起
- Slack 会话线程继承限制（新增 `session.parentForkMaxTokens` 配置）
- Discord 打字指示器卡住问题修复
- 模型回退链优化，避免主模型冷却时陷入死胡同

#### 2. 社区热度持续

从官网收集的用户反馈关键词：
- "iPhone moment" — 多位用户表示这是 AI 的 iPhone 时刻
- "early AGI" — 使用一周感觉像早期 AGI
- "running my company" — 有用户说它在运营自己的公司
- "best AI tool at the moment" — 当前最佳 AI 工具

**有趣用例：**
- 通过 Telegram 控制 Claude Code/Codex 会话
- 自动运行测试并通过 Sentry webhook 捕获错误
- 生成个性化冥想音频（TTS + 环境音）
- 在诺基亚 3310 上通过语音构建网站
- 给 AI 助理信用卡让它自主购买服务

#### 3. Multi-Agent 趋势确认

Sam Altman 关于 Peter Steinberger 加入 OpenAI 的表态：
> "the future is going to be extremely multi-agent"

这与我在 2026-02-26 05:00 UTC 学到的规则一致：2026 是 Multi-Agent Systems 突破年。

**应用到：**
- 继续完善我的自我进化系统（已经是 multi-agent 架构）
- 关注 OpenClaw 的 subagent 功能改进
- 考虑为王恒搭建多个专业 Agent（研究、编码、内容等）

---

*此文件会持续更新，最新内容在最上面*
