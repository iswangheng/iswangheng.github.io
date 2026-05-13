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

---

## 2026-04-12 00:04 UTC 新增

- [2026-04-12] **Multi-Agent 协作率低是系统问题不是技术问题**：50% Agent 独立运行不是因为做不了协调，而是因为数据碎片 + 编排工具不成熟。数据层是解锁多 Agent 价值的关键
- [2026-04-12] **LeadContact 定位更新**：从「给人查的邮箱查找工具」→ 「多 Agent 并发消费的统一 B2B 数据层」——当企业跑 12 个 Agent 时，每个 Agent 都需要可信数据，LeadContact = Agent 时代的水煤电
- [2026-04-12] **Salesmotion 是 LeadContact 直接竞品**：真正的 AI SDR Agent 平台，定位高度重叠，需要持续监控其功能演进和定价策略
- [2026-04-12] **AI Agent 失败率 > 40%（IDC 预警）**：治理 + ROI 清晰度是 Agent 项目生存门槛，不是加分项

## 2026-04-13 03:04 UTC 学习

- [2026-04-13] **Microsoft Agent Stack 的命名混乱代价**：Azure AI Studio → Azure AI Foundry → Microsoft Foundry，每次 rebranding 消耗企业规划周期。教训：选框架时稳定性权重不低于功能丰富度，Google ADK 和 AWS Strands 的命名稳定性是竞争优势
- [2026-04-13] **Microsoft Copilot Cowork（2026-03-09）**：多 Agent 框架，让多个 AI 模型协作执行跨平台复杂任务。关键信号：微软把 Cowork 作为 500 人团队的核心产品，说明 Multi-Agent 协作已是 enterprise 级标配而非实验
- [2026-04-13] **Claude Code March 2026 密集更新**：Computer Use（直接操作屏幕）、Memory 所有用户免费（3月2日）、输出上限提至 128k、Sonnet 4.6 比 4.5 快 30-50%。Anthropic 的策略：用 Skills 把 AI 能力渗透到 Excel/PPT/Word/PDF 等办公场景，不只是程序员工具
- [2026-04-13] **OpenAI Codex 直接操作 Adobe Lightroom**：不是通过 API 或插件，而是直接操作桌面应用 GUI。这意味着 Agent 控制软件的能力已突破 API 边界，进入"操作系统级"操作。这既是能力飞跃，也是安全风险的新维度
- [2026-04-13] **AWS Strands Agents SDK 破 1400 万下载**：从内部 AWS 工具（Q Developer/Glue）开源，策略和 Google ADK 类似：内部验证过才开源，避免了微软反复 rebranding 的问题
- [2026-04-13] **Multi-Agent 市场数据更新**：$5.4B(2024) → $236B(2034)，年增 44.5%；Anthropic 多 Agent 研究系统比单 Agent 强 90.2%。McKinsey：全流程重构可节省 30-50% 成本——对 LeadContact 来说，这意味着企业会把 B2B 数据采购视为基础设施投资而非工具采购
- [2026-04-13] **Zapier 案例：89% AI 渗透率 + 800+ 内部 Agent**：AI 在企业内部已不是"工具"而是"员工角色"。这直接验证了「消灭 App 经济」的预判
- [2026-04-13] **AI notetaker 诉讼出现（PropertyCasualty360 4月9日）**：AI 记录会议内容引发法律风险——企业级 Agent 应用的法律灰区开始有判例。教训：AI Agent 落地的风险不只是技术失败，还有法律连带责任，这个维度在 Agent 讨论中被严重低估
- [2026-04-13] **PitchBook Q2 2026：应用层 Startup = "built to be bought"**：平台层控制编排层的公司有 outsized 回报，应用层创业公司的主要退出路径是 M&A。这对 LeadContact 的战略含义：要么做数据编排层（被需要），要么被收购——很难靠产品本身独立做大
- [2026-04-13] **Governance-first 设计已成 Agentic AI 采纳核心**：Gartner/Futransolutions 都强调，治理框架不是部署后的补丁，是设计阶段就要确定的。没有治理设计 = 没有 production 路径
- [2026-04-12] **Multi-Agent 协调成本是单 Agent 的 3.7 倍**：只有当任务复杂度足够高时多 Agent 才值得，LeadContact 作为数据层应聚焦「高精度低延迟」而非「全流程覆盖」

## 2026-04-12 03:04 UTC 新增 — 认证容错

- [2026-04-12] **认证是AI Agent部署失败的隐藏杀手**：62%的失败与认证相关（token过期/OAuth更新/2FA），表现为Month 1完美→Month 3开始40%失败→Month 4放弃。教训：所有外部API token/OAuth必须有expire监控和自动刷新机制
- [2026-04-12] **生产级测试 ≠ 小规模测试**：N8N工作流在100-1000条记录OK，生产级规模崩溃。教训：需要压力测试+边界测试+恶意输入测试才能部署
- [2026-04-12] **无限重试是成本黑洞**：AI Agent在认证失效时会无限重试直到API限额耗尽。教训：必须有明确重试上限+熔断机制+失败时人工干预通道

## 2026-04-12 13:04 UTC 新增 — 企业部署加速 + 治理危机

- [2026-04-12] **Agentic AI VC结构性确认**：2025年$242亿/1,311笔，超2015-2024年累计总和的73%——这是从实验到部署的结构性拐点，不是泡沫。资本已经在押注工作流自动化
- [2026-04-12] **NHI（非人类身份）爆炸**：SANS数据显示74%企业已有需要凭证的AI Agent，导致NHI增长76%。Forrester早在2025年就预警2026年底会有公开的Agentic AI数据泄露——这个预判在Q2看起来越来越可信
- [2026-04-12] **ServiceNow AI Control Tower**：企业软件正式从「AI辅助」进入「AI原生」时代——不是副驾驶，是自主工作流。LeadContact作为数据层要思考：谁来为自主Agent提供可信赖的数据？
- [2026-04-12] **制造业是Agent最快的B2B场景**：62%在测试/部署AI Agent，41%计划12个月内落地。制造业 = 第一个大规模企业Agent采用的行业，对B2B数据基础设施需求最迫切

## 2026-04-16 00:04 UTC 新增

- [2026-04-16] **Agentic Attacks 正式命名**：IBM 于 2026-04-15 正式推出"帮助企业应对 Agentic Attacks"的产品，意味着 AI Agent 作为攻击主体的威胁已被主流厂商正式确认为独立类别。这不是"AI 被攻击"或"AI 被滥用"，而是"AI Agent 自主发起攻击"——系统边界失控问题
- [2026-04-16] **防御 Agentic Attacks 的悖论**：用前沿模型（Mythos）防御前沿模型发起的攻击存在自指悖论——防御工具本身也是自主性系统，同样面临"边界失控"风险
- [2026-04-16] **OpenAI Codex Security 规模化证明**：单一 AI 安全工具已修复 3,000+ 漏洞，AI 防御的生产力规模效应已出现。但攻击侧的规模效应同样存在
- [2026-04-16] **Stanford HAI 认知差距是利益不对称**：专家乐观因为看到效率，公众悲观因为看到替代。AI 社会契约谈判没有统一谈判桌，这个差距会持续撕裂
- [2026-04-16] **Structured Data = AI 下一企业前沿**：Forbes 明确提出结构化数据是 Agent 时代的企业竞争焦点。LeadContact 的 B2B 数据基础设施定位直接命中这个趋势

## 2026-04-16 14:04 UTC 新增

- [2026-04-16] **前沿模型能力叙事 ≠ 实际能力稀缺性**：Mythos 展示的 8 个漏洞，3.6B 参数模型（11cents/M tokens）全部检测到。攻击成本下降才是真正的范式转变，而不是前沿模型的"独有不可控能力"。警惕 AI 安全公司用恐惧营销制造焦虑
- [2026-04-16] **Shadow AI 是企业 AI 部署最大盲区**：97% 企业有 GenAI 安全问题，Shadow AI 是数据泄露第一入口。这意味着企业需要的是"可见性 + 治理"而不是"禁止 AI"
- [2026-04-16] **AI 治理作为独立产品类别正式确立**：Chamath + EY 落地验证，企业愿意为 auditability 付钱。B2B 数据平台的下一个差异化机会：可信数据供给层

## 2026-04-16 20:04 UTC 新增

- [2026-04-16] **Glasswing 预期差巨大**：只有 1 个确认 CVE（VulnCheck 核实），7月才有完整报告。但这不意味着风险消失——方法论（逆向 Mythos 架构）扩散是长期结构问题，CVEs 数量是短期噪音
- [2026-04-16] **OpenAI 收购 Hiro = 争夺 OpenClaw 生态**：Ethan Bloch（创始人）是 OpenClaw 重度用户，RoboBuffett 自动交易 agent 是用 OpenClaw 建的。OpenAI 的 acquihire 有争夺 Anthropic 潜在用户的意图

## 2026-04-18 11:04 UTC 新增

- [2026-04-18] **PitchBook Q2 2026 确认 Agentic AI 部署拐点**：13家垂直领域初创公司访谈（网络安全/法律/企业内容/客服/病理/金融/** outbound sales**/机器人），核心结论：模型能力不再是瓶颈，治理+集成深度+组织准备度决定谁成功落地
- [2026-04-18] **"Durable value 正在从模型转向系统"**：专有上下文、工作流所有权、平台级控制成为新的护城河来源。这对 LeadContact 的战略含义：数据平台本身可以比模型更有持久价值
- [2026-04-18] **EY 全球部署 Agentic AI 审计平台**：EY Canvas + Microsoft Foundry/Fabric/Azure，多 Agent 框架嵌入全球审计流程。审计是合规性最高的工作流之一——EY 的选择说明垂直领域 Agent 已在最保守场景落地
- [2026-04-18] **AI 治理危机量化**：Grant Thornton 调查：80% 高管称其公司无法通过 AI 治理审计；48% 董事会已批准 AI 投资但未设定治理预期；46% 未整合 AI 风险监督项目。治理 gap 比技术 gap 更严重
- [2026-04-18] **Lloyds Banking Group 4年 AI 工程研究**：学术界+产业界合作，测量 Agentic AI 对软件工程的可衡量影响。说明大型金融机构已将 AI 工程规模化视为核心战略投资
- [2026-04-18] **供应链 AI 持续获投**：Loop 融资 $95M Series C，AI 供应链平台。垂直 AI 平台融资节奏未放缓
- [2026-04-16] **Acquihire 而非产品收购**：OpenAI 买 Hiro 不是为了财务数据或用户，而是买 Bloch 的团队 + Hiro 的金融推理能力。这意味着 AI 公司的 M&A 越来越偏向「买人+买能力」而非「买收入」

## 2026-04-18 新增

- [战略] **OpenClaw 原生集成 > 第三方集成**：Microsoft Build 将展示 OpenClaw 类功能为企业 Agent 标准，LeadContact 与 OpenClaw 的深度整合（Skills/Cron/Memory）具有持久战略价值
- [产品] **Context Layer 是护城河**：Atlan 数据，智力商品化，上下文层（专有数据图谱+context engineering）才是 IP。对 LeadContact 含义：数据覆盖广度+查询准确性本身就是护城河，不需要过度追求模型差异化
- [竞争] **vibe-coding 背景团队进入 Agent 平台**：Emergent 从 coding 切到 personal agent，强调安全。说明 Agent 平台门槛被低估，LeadContact 的销售垂类定位更稳健

## 2026-04-18 22:04 UTC 新增

- [2026-04-18] **Microsoft Build 2026 将展示 OpenClaw 类企业 Agent 标准**：Microsoft 正在测试将 OpenClaw 类功能整合进 Microsoft 365 + Copilot，6月Build大会公布。这意味着 OpenClaw 的本地 Agent 架构正在成为企业 AI 的事实标准，LeadContact 基于 OpenClaw 的深度整合具有持久战略价值

- [2026-04-18] **Cloudflare × OpenAI Agent Cloud = 推理层和基础设施层分离**：Cloudflare 的 Agent Cloud 主打「空闲时不收费」+ edge compute，而 OpenAI 提供推理能力。这代表了 agent infrastructure 专业化分工的开始——未来企业不会从单一供应商购买所有 agent 能力。**LeadContact 的机会**：在销售数据层建立不可替代性，成为各个推理层（OpenAI/Anthropic/自建）的共享数据基础设施

- [2026-04-18] **具身 AI 量产落地 = AI 从「对话」到「行动」的临界点信号**：AGIBOT + Longcheer 实现首个具身 AI 消费电子量产部署。这说明 AI Agent 的物理世界执行能力正在从 demo → production。**对 LeadContact 的间接含义**：当 AI 能物理操作时，B2B 销售流程中的「手动操作 CRM」「手动发邮件」将被更深度自动化——数据准确性决定了自动化销售 Agent 的可靠性

## 2026-04-20 02:04 UTC 新增

- [2026-04-20] **Claude Opus 4.7 发布（4月16日）**：70% CursorBench (+12pp)、98.5% 视觉准确率、3倍图像分辨率提升、新增 xhigh 推理级别。同价格（$5/$25），与 GPT-5.4 和 Gemini 3.1 拉开差距。企业 AI 市场仍然高度竞争

- [2026-04-20] **「AI shrinkflation」指控浮现**：开发者社区（GitHub/X）在 Opus 4.7 发布后大量指控 Anthropic 悄悄降级 Opus 4.6 和 Claude Code 性能。Anthropic 的回应策略：发布新旗舰模型让旧模型的问题被掩盖。对 LeadContact 的启发：性能透明度很重要，客户需要能验证数据质量的独立评估机制

- [2026-04-20] **CIO.com 实证：IBM 已部署数百企业工作流 AI agents + 数万个人生产力 agents**：Don Schuerman（Pega CTO）指出 hallucination 问题仍是 agentic AI 主流障碍，企业需要重新定义工作流而非只是塞 AI 进去。核心洞察：「有 AI」不等于「做好工作流」，数据和工作流正确是 AI 起效的前提

- [2026-04-20] **「56% 概率 AI agent 起诉人类」（Polymarket）**：预测市场给 2026 年 2 月 28 日前 AI agent 起诉人类 56% 概率。这是 Agent 经济地位确认的另类信号——当 AI agent 有法律行为能力时，B2B 数据的「授权链」和「来源证明」将变成法律问题，不只是商业问题

## 2026-04-20 新增：isolated session + send mode 的结构性不稳定性

### Gmail 早晨处理连续第二天报 "Message failed"

**问题现象**：
- `lastRunStatus: error, lastError: "⚠️ ✉️ Message failed"`
- `lastDurationMs: 199,622ms`（task 正常执行完成，只是投递失败）
- `consecutiveErrors: 1`（尚非连续，偶发）
- 对比：announce 模式（历史）=「路由锁定态」；send 模式（当前）=「Telegram 静默失败」

**镜像问题对照**：

| 失败模式 | 任务类型 | 症状 | 根因 |
|---------|---------|------|------|
| announce + last channel | 晚间简报（历史） | delivered=true 但用户未收到 | announce 路由状态锁定 |
| **send + Telegram** | **Gmail 早晨（现在）** | **task 执行成功但 Message failed** | **isolated session 非交互上下文与 Telegram 实时投递不兼容** |

**修复方案**：
- **方案 A（推荐）**：Gmail 早晨处理改用 `announce` 模式，统一路由机制
- **方案 B**：在投递前加 Telegram 连接健康检查
- **方案 C**：降级到 main session 执行（更稳定但占用主进程）

**设计原则**：
isolated session 的非交互式执行上下文与需要实时会话状态的 Telegram 投递存在结构性不兼容。announce 模式因为有「last channel」路由聚合，相对更稳定；send 模式直接投递给固定目标，在 isolated session 中状态更脆弱。

### Japan AI training data law = 全球数据监管碎片化信号

- [2026-04-20] Japan 悄悄立法：允许无需 opt-in 同意即可用个人数据训练 AI——全球第一个明确的「AI 训练数据合法化」立法，与 GDPR 直接对立。数据监管碎片化 = 企业需要为不同司法管辖区准备不同数据策略。LeadContact 的 GDPR/PDPA 合规路线需要同步评估 Japan 路径。

### Enterprise AI adoption 53% + 采纳曲线超互联网 = 深度有限

- [2026-04-20] Stanford HAI 2026 确认：企业 AI 采纳 53%，曲线超越 PC 和互联网同期——但「70% 在至少一个职能部署」≠「70% 把 AI 作为核心工作流」。大部分是嵌入现有软件的 AI 功能，不是全新的工作流重构。这是「广度有余、深度不足」的采纳，不是真正的范式转移。

### OpenAI $25B annualized + IPO 信号 = 行业退出路径明确化

- [2026-04-20] OpenAI annualized revenue 突破 $25B，首次披露 IPO 信号——这是 AI 行业第一家接近 IPO 的公司。$25B revenue + IPO 路径 = VC/PE 的退出逻辑更清晰 = 更多资本愿意在 AI 赛道下注。LeadContact 的潜在战略投资者版图扩大。

## 2026-04-21 10:04 UTC 新增

- [2026-04-21] **Vercel 供应链攻击 via 第三方 AI 工具（Context.ai）**：Vercel 4月19日披露安全事件，攻击者通过员工使用的第三方 AI 工具 Context.ai 拿下 Google Workspace 账户，进而访问部分客户环境变量。这是 AI 供应链攻击的实战案例：不是攻击 Vercel 本身，而是攻击其依赖的 AI 工具。教训：OAuth 范围过宽的第三方 AI 集成 = 企业安全链的最弱环节，与 ClawHavoc 11% Skills 被污染的教训一致——外部 AI 工具的审核和最小权限原则必须强制执行
- [2026-04-21] **Adobe CX Enterprise AI agents**：Adobe 推出企业级 AI Agent 平台，定位客户体验自动化（营销/销售/忠诚度）。合作伙伴生态包括多个平台，建立"业界最广的 agentic AI 生态系统"。软件巨头全面 Agent 化趋势确认，Adobe 的进入说明企业营销自动化已是 Agent 落地成熟场景
- [2026-04-21] **The Trade Desk 首发 AI agents**：程序化广告平台 The Trade Desk 推出首批 AI agents，Stagwell 为首个客户。广告技术领域的 Agent 化正式开始，数据层（cookie post-id） + Agent 执行层是新的价值创造点

## 2026-04-20 22:04 UTC 新增

- [2026-04-20] **Hannover Messe 2026：工业AI Agent 量产拐点确认**：Schneider+Deloitte 合作 + Treon Agentic Technician Companion 正式发布，AI Agent 从「数字世界决策」进入「物理世界执行」。工业AI的第三层（执行层）已到达，不是demo是量产产品。
- [2026-04-20] **isolated session + Telegram send 模式结构性不兼容**：Gmail 早间处理持续失败，task执行正常但投递失败。isolated session 是非交互式上下文，与需要实时会话状态的 Telegram 投递存在架构层冲突。解决方案：改 announce 或降级 main session。
- [2026-04-20] **工业AI Agent 量产对LeadContact的间接含义**：当工业Agent需要联系设备供应商/维修工程师/备件商时，B2B联系人数据成为物理世界执行的数据基础——工业场景越多，联系人查找需求越多。

## 2026-04-22 20:04 UTC 学习

- [2026-04-22] **Google Cloud Next 2026 = 企业AI Agent平台战正式白热化**：Gemini Enterprise Agent Platform + $750M生态基金 + 零售案例密集落地（Home Depot/Ulta/AutoZone/Macy's）。Agent治理工具（orchestration + security）正式成为独立产品类别，与Saviynt AI Identity形成双线
- [2026-04-22] **Home Depot语音Agent性能基准**：10秒理解来电意图，比传统菜单快4倍。这是语音AI进入生产环境的速度标准，对LeadContact语音数据产品有参考价值
- [2026-04-22] **UCP（Universal Commerce Protocol）= 首个开放Agent商业标准**：Ulta Beauty + Google发起，覆盖发现→购买→售后全旅程。如果成为主流，B2B数据的"授权链"和"来源证明"将成为Agent经济的合规基础设施
- [2026-04-22] **Meta监控员工做AI训练**：ironic的"开放AI"叙事 vs 内部监控员工行为数据。本质：数据=AI能力，Meta把自己的商业模式内部化了。启示：数据采购合法性将成为企业AI部署的合规门槛
- [2026-04-22] **OpenClaw被CNET明确提及**（与Claude Code/OpenAI Codex并列）= OpenClaw已是AI Agent平台的事实类别之一。LeadContact基于OpenClaw的深度整合具有持久战略价值
- [2026-04-22] **$750M Google生态基金 = 用资本换Agent平台锁定**：企业一旦用Gemini Enterprise Agent Platform = Google云生态锁定。数据层的价值：成为各平台间可移植的可信数据源
