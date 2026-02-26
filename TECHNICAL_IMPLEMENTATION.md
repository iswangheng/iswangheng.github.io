# 🔧 技术架构和实施细节

## 系统架构图

```
┌──────────────────────────────────────────────────────────────┐
│                    用户 (You)                                │
└────────────────────┬─────────────────────────────────────────┘
                     │ Feishu / Telegram / WhatsApp
                     │
┌────────────────────▼─────────────────────────────────────────┐
│                  OpenClaw (AI 助手)                          │
│  ┌────────────────────────────────────────────────────────┐  │
│  │          OpenClaw 核心 (你当前运行的)                  │  │
│  └────────────────────────────────────────────────────────┘  │
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ 竞品分析器    │  │ 内容生成器    │  │ 自动发布器    │      │
│  │Competitor     │  │Content       │  │Publisher     │      │
│  │Analyzer      │  │Generator     │  │              │      │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘      │
│         │                 │                 │               │
│  ┌──────▼───────┐  ┌────▼────────┐  ┌────▼─────────┐     │
│  │ Playwright   │  │ LLM (GLM)   │  │ WordPress    │     │
│  │ Chromium     │  │             │  │ REST API     │     │
│  │ 浏览器       │  │             │  │              │     │
│  └──────┬───────┘  └──────┬──────┘  └──────┬───────┘     │
│         │                 │                 │               │
│         ▼                 ▼                 ▼               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │ 竞品博客网站  │  │ 生成的文章    │  │ 博客平台     │      │
│  │              │  │              │  │              │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
│                                                              │
└──────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────▼─────────┐
                    │  外部服务           │
                    ├─────────────────────┤
                    │ • Google Analytics │
                    │ • SimilarWeb       │
                    │ • SEO 工具         │
                    └─────────────────────┘
```

---

## 📂 技能结构设计

### 技能 1：`competitor-analyzer`

**目录结构：**
```
/skills/competitor-analyzer/
├── SKILL.md              # 技能说明
├── package.json
├── lib/
│   ├── analyzer.js       # 分析器核心
│   ├── scraper.js       # 网页抓取
│   └── models/
│       └── article.js    # 文章数据模型
└── config/
    └── competitors.json  # 竞品列表配置
```

**核心功能：**
```javascript
class CompetitorAnalyzer {
  // 1. 搜索竞品
  async findCompetitors(keywords, count = 10)

  // 2. 获取博客 URL
  async getBlogUrl(domain)

  // 3. 提取文章列表
  async extractArticles(blogUrl, limit = 20)

  // 4. 分析单篇文章
  async analyzeArticle(articleUrl)

  // 5. 生成风格报告
  async generateStyleReport(articles)

  // 6. 排序文章（按预估流量）
  async rankByTraffic(articles)
}
```

**数据模型：**
```javascript
{
  competitor: {
    name: "CompetitorName",
    domain: "example.com",
    blogUrl: "https://example.com/blog",
    alexaRank: 10000,
    similarwebScore: 85
  },

  article: {
    title: "Article Title",
    url: "https://example.com/blog/article",
    estimatedTraffic: 5000,
    publishedAt: "2026-01-15",
    socialShares: {
      twitter: 120,
      linkedin: 45,
      facebook: 30
    },
    content: {
      wordCount: 1500,
      headingCount: 8,
      imageCount: 5,
      hasCodeBlocks: true,
      tags: ["tag1", "tag2"]
    },
    style: {
      titleLength: 45,
      paragraphAvgLength: 80,
      usesLists: true,
      usesQuotes: true,
      tone: "professional"
    }
  }
}
```

---

### 技能 2：`blog-generator`

**目录结构：**
```
/skills/blog-generator/
├── SKILL.md
├── package.json
├── lib/
│   ├── generator.js      # 内容生成器
│   ├── outline.js       # 大纲生成
│   ├── writer.js        # 内容写作
│   └── reviewer.js      # 质量检查
└── templates/
    ├── blog-post.txt    # 文章模板
    └── style.json       # 风格配置
```

**生成流程：**
```javascript
class BlogGenerator {
  // 1. 分析竞品风格
  async analyzeCompetitorStyle(article)

  // 2. 生成主题列表
  async generateTopics(product, audience, count = 10)

  // 3. 生成文章大纲
  async generateOutline(topic, styleTemplate)

  // 4. 逐段生成内容
  async generateContent(outline, productInfo)

  // 5. 添加产品信息
  async insertProductInfo(content, productFeatures)

  // 6. 质量检查
  async review(content, criteria)

  // 7. SEO 优化
  async optimizeSEO(content, keywords)
}
```

**生成大纲示例：**
```javascript
{
  title: "如何使用 [产品] 解决 [问题]",
  metaDescription: "150字描述",
  sections: [
    {
      heading: "引言：为什么 [问题] 很重要",
      wordCount: 200,
      type: "intro"
    },
    {
      heading: "传统的解决方案及其局限",
      wordCount: 300,
      type: "problem",
      include: ["bullet points", "example"]
    },
    {
      heading: "[产品] 的独特优势",
      wordCount: 400,
      type: "solution",
      include: ["features", "comparison table", "screenshot placeholder"]
    },
    {
      heading: "实际案例：公司 X 如何使用 [产品]",
      wordCount: 350,
      type: "case_study",
      include: ["metrics", "quote"]
    },
    {
      heading: "5 步快速上手 [产品]",
      wordCount: 400,
      type: "tutorial",
      include: ["numbered list", "code blocks", "screenshots"]
    },
    {
      heading: "总结与下一步",
      wordCount: 150,
      type: "conclusion",
      include: ["CTA"]
    }
  ],
  targetWordCount: 1800,
  seoKeywords: ["关键词1", "关键词2", "关键词3"]
}
```

---

### 技能 3：`wordpress-publisher`

**目录结构：**
```
/skills/wordpress-publisher/
├── SKILL.md
├── package.json
├── lib/
│   ├── publisher.js      # 发布器
│   ├── auth.js          # 认证
│   ├── media.js         # 媒体上传
│   └── seo.js           # SEO 设置
└── config/
    └── wordpress.json    # WordPress 配置
```

**核心功能：**
```javascript
class WordPressPublisher {
  constructor(apiUrl, username, password) {
    this.apiUrl = apiUrl;
    this.auth = this.generateAuth(username, password);
  }

  // 1. 获取/创建分类
  async getOrCreateCategory(name)

  // 2. 获取/创建标签
  async getOrCreateTag(name)

  // 3. 上传图片
  async uploadImage(imageUrl, altText)

  // 4. 创建文章草稿
  async createDraft(article)

  // 5. 设置 SEO
  async setSEO(postId, meta)

  // 6. 定时发布
  async schedulePublish(postId, date)

  // 7. 立即发布
  async publish(postId)

  // 8. 批量发布
  async publishBatch(articles, schedule)
}
```

**API 调用示例：**
```javascript
// 创建文章
async createArticle(article) {
  const response = await fetch(`${this.apiUrl}/wp-json/wp/v2/posts`, {
    method: 'POST',
    headers: {
      'Authorization': `Basic ${this.auth}`,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      title: article.title,
      content: article.content,
      status: 'publish',
      categories: [await this.getCategoryId('技术')],
      tags: article.tags,
      featured_media: article.featuredImageId,
      meta: {
        yoast_wpseo_metadesc: article.metaDescription,
        yoast_wpseo_focuskw: article.seoKeyword
      }
    })
  });

  return response.json();
}
```

---

### 技能 4：`content-tracker`

**目录结构：**
```
/skills/content-tracker/
├── SKILL.md
├── package.json
├── lib/
│   ├── tracker.js        # 流量追踪
│   ├── analyzer.js       # 数据分析
│   └── reporter.js       # 报告生成
└── config/
    └── analytics.json    # GA 配置
```

**核心功能：**
```javascript
class ContentTracker {
  constructor(gaPropertyId, credentials) {
    this.gaPropertyId = gaPropertyId;
    this.credentials = credentials;
  }

  // 1. 获取文章流量
  async getArticleMetrics(postId, startDate, endDate)

  // 2. 获取热门文章
  async getTopPosts(limit = 10)

  // 3. 分析趋势
  async analyzeTrend(postId, days = 30)

  // 4. 对比竞品
  async compareWithCompetitors()

  // 5. 生成报告
  async generateReport(period = 'week')

  // 6. 发现优化机会
  async findOptimizationOpportunities()
}
```

---

## 🔄 自动化工作流

### 完整流程示例

```javascript
// 1. 每周一：竞品分析
await cron.schedule('0 9 * * 1', async () => {
  const articles = await analyzer.extractArticles(competitors);
  const ranked = await analyzer.rankByTraffic(articles);
  await analyzer.saveToDatabase(ranked.slice(0, 20));
});

// 2. 每周二：生成内容
await cron.schedule('0 9 * * 2', async () => {
  const topArticles = await analyzer.getTopArticles(5);
  const topics = await generator.generateTopics(product, audience, 3);
  const articles = [];

  for (const topic of topics) {
    const style = analyzer.getStyleFromCompetitor(topArticles[0]);
    const outline = await generator.generateOutline(topic, style);
    const content = await generator.generateContent(outline, product);
    articles.push(content);
  }

  await generator.saveToDatabase(articles);
});

// 3. 每周三、周五：发布
await cron.schedule('0 9 * * 3,5', async () => {
  const article = await generator.getNextScheduledArticle();
  await publisher.createDraft(article);
  await publisher.setSEO(article.postId, article.seo);
  await publisher.schedulePublish(article.postId, new Date());
});

// 4. 每周日：分析报告
await cron.schedule('0 9 * * 0', async () => {
  const report = await tracker.generateReport('week');
  await message.send(report, 'channel:feishu');
});
```

---

## 📊 数据库设计

### 使用 JSON 文件（简单方案）

```json
// competitors.json
{
  "competitors": [
    {
      "id": "comp1",
      "name": "Competitor A",
      "blogUrl": "https://competitor-a.com/blog",
      "lastAnalyzed": "2026-02-03",
      "topArticles": []
    }
  ]
}

// articles.json
{
  "generated": [
    {
      "id": "art1",
      "title": "Article Title",
      "status": "published",
      "wordpressId": 123,
      "publishedAt": "2026-02-03",
      "metrics": {
        "views": 0,
        "clicks": 0
      }
    }
  ],
  "scheduled": []
}

// style-templates.json
{
  "templates": [
    {
      "id": "tech-blog",
      "name": "技术博客风格",
      "structure": {...}
    }
  ]
}
```

---

## 🚀 实施步骤

### Phase 1：环境搭建（Week 1）

```bash
# 1. 安装 WordPress（Docker）
docker run -d \
  --name wordpress \
  -p 8080:80 \
  -e WORDPRESS_DB_HOST=wordpress-db \
  -e WORDPRESS_DB_USER=wpuser \
  -e WORDPRESS_DB_PASSWORD=wppassword \
  -e WORDPRESS_DB_NAME=wpdb \
  wordpress:latest

# 2. 配置 Nginx 反向代理
# blog.yourdomain.com -> localhost:8080

# 3. 安装必要插件
# - Yoast SEO
# - Classic Editor
# - WP REST API Authentication

# 4. 获取 API 凭证
# WordPress -> 用户 -> 个人资料 -> 应用程序密码
```

### Phase 2：技能开发（Week 2-3）

```bash
# 1. 创建技能
mkdir -p /root/.openclaw/skills/competitor-analyzer

# 2. 初始化
cd /root/.openclaw/skills/competitor-analyzer
npm init -y
npm install playwright cheerio axios

# 3. 开发核心功能
# ...

# 4. 测试技能
# ...
```

### Phase 3：集成测试（Week 4）

```javascript
// 1. 测试完整流程
const competitor = "competitor.com";
const articles = await analyzer.extractArticles(competitor);
const topArticle = articles[0];

const topic = await generator.generateTopic(product);
const outline = await generator.generateOutline(topic, topArticle.style);
const content = await generator.generateContent(outline, product);

const postId = await publisher.createDraft(content);
await publisher.publish(postId);

// 2. 验证发布
// 检查 WordPress 博客

// 3. 验证 SEO
// 检查 Search Console
```

---

## 📝 需要你提供的信息

为了启动项目，我需要：

1. **产品信息**
   - 产品名称
   - 主要功能/卖点
   - 目标受众
   - 价格/商业模式

2. **竞品信息**
   - 已知竞品列表（如果有）
   - 竞品博客 URL（如果有）

3. **博客配置**
   - WordPress 实例（安装新的或使用现有的）
   - 域名（如果有的话）
   - 语言偏好（中文/英文）

4. **发布策略**
   - 每周发布频率
   - 发布时间偏好
   - 内容类型偏好（教程/案例/分析）

---

**准备开始了吗？** 给我这些信息，我就可以开始实施了！
