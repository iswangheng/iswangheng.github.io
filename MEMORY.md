# MEMORY.md - 长期记忆

## 服务器信息

### 主服务器
- **公网IP：** 43.163.220.15
- **云平台：** 腾讯云
- **操作系统：** OpenCloudOS 9.4
- **内网IP：** 10.7.4.17

### Web服务
- **计算器项目：** `/root/.openclaw/workspace/calculator.html`
- **HTTP服务器：** python3 -m http.server 8000
- **访问地址：** http://43.163.220.15:8000/calculator.html
- **端口：** 8000（安全组已配置）
- **启动命令：** `python3 -m http.server 8000 --directory /root/.openclaw/workspace &`

### 项目文件
```
/root/.openclaw/workspace/
├── calculator.html      # 简单计算器网页
├── AGENTS.md           # 工作区文档
├── BOOTSTRAP.md        # 首次启动引导
├── HEARTBEAT.md        # 心跳任务配置
├── IDENTITY.md         # 身份信息
├── SOUL.md             # 灵魂/个性定义
├── TOOLS.md            # 工具使用笔记
└── USER.md             # 用户信息
```

---

*更新时间：2025-02-02*

## 产品信息

### LeadContact

### 产品定位
**LeadContact** - B2B 销售触达工具，帮助销售和招聘团队快速找到企业联系人和关键决策者

**核心价值主张：**
> "Find Any Email, Find Any Phone Number" （查找任何邮箱，查找任何电话号码）

### 核心功能
1. **邮箱查找** - 120M+ 邮箱，98% 准确率
2. **电话号码查找** - 60M+ 电话，多源验证
3. **决策者查找** - 270M+ 决策者，按职位快速查找
4. **Chrome 扩展** - 在 LinkedIn 上实时显示联系信息

### 4 个使用场景
- LinkedIn 个人资料页 - 查看档案时显示联系信息
- LinkedIn 公司页面 - 查找决策者和联系信息
- LinkedIn 搜索结果 - 批量导出联系方式
- 任何网站 - 浏览公司网站时即时显示决策者

### 产品形态
- **主产品：** Chrome 扩展（linkedcrm-al-linkedin-ema）
- **开发者版：** API（4 个端点：Email/Phone/Decision Maker/Company）
- **商业模式：** Freemium（免费试用 + Free/Basic/Pro/Unlimited 付费）
- **联盟计划：** Affiliate Program

### 竞争优势
1. 98% 准确率（多数据源交叉验证）
2. 更低成本（替代多个 $289/月的工具）
3. AI 驱动（智能填充缺失邮箱）
4. 无缝集成（Chrome 扩展，无需切换）

### 目标用户
- B2B 销售团队
- 招聘人员
- 业务拓展 (BD)
- 营销团队

### 公司信息
- **公司名称：** Willing Tech Pte. Ltd.
- **联系邮箱：** hello@leadcontact.ai
- **品牌关联：** linkedcrm.ai（博客指向）
- **产品网址：** https://leadcontact.ai

### 内容营销方向（建议）
1. B2B 销售技巧（冷邮件、LinkedIn 策略）
2. 数据验证和准确性（98% 准确率的技术实现）
3. 销售技术栈（Chrome 扩展工具推荐、自动化实践）
4. 案例研究（客户成功故事、ROI 计算）
5. 行业洞察（B2B 销售趋势、AI 在销售中的应用）

### 竞品
- Hunter.io（已研究，450+ 篇博客，专注冷邮件领域）

---

## 记忆文件组织

```
memory/
├── products/
│   └── leadcontact/          # LeadContact 产品详细信息
└── competitors/
    └── hunter/              # Hunter.io 竞品信息
```

---

*更新时间：2026-02-03*
