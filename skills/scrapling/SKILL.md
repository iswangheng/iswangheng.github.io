---
name: scrapling
description: 使用 Scrapling 抓取网页内容，提取干净的 Markdown。适用于微信公众号、有反爬机制的网站、需要全文提取的场景。
metadata:
  version: 1.0.0
---

# scrapling - 网页内容提取工具

## 用途
当需要抓取网页内容时，使用 Scrapling 提取干净的 Markdown 格式内容。

## 核心能力
1. **绕过反爬** - 使用 StealthyFetcher 绕过 Cloudflare 等反爬机制
2. **微信公众号** - 能抓取其他工具抓不到的公众号文章
3. **干净 Markdown** - 自动提取正文，去除导航、广告、侧边栏
4. **无 API 限制** - 不需要 API Key，无调用次数限制

## 安装依赖
```bash
pip install scrapling html2text
pip install playwright && playwright install chromium
pip install browserforge curl_cffi
```

## 用法

### Python 脚本方式
```python
from scrapling import Fetcher
import html2text

fetcher = Fetcher()
response = fetcher.get(url)

# 找到文章正文
body = (
    response.find('article') or 
    response.find('main') or 
    response.find('.rich_media_area_primary') or
    response.find('#js_content') or
    response.find('body')
)

# 转换为 Markdown
h = html2text.HTML2Text()
h.ignore_links = False
h.ignore_images = False
h.body_width = 0
md = h.handle(body.html_content)
print(md)
```

### 命令行方式
```bash
python3 /root/.openclaw/workspace/scripts/scrapling_fetch.py <url> [max_chars]

# 示例
python3 /root/.openclaw/workspace/scripts/scrapling_fetch.py "https://example.com" 30000
python3 /root/.openclaw/workspace/scripts/scrapling_fetch.py "https://mp.weixin.qq.com/s/xxx" 30000
```

## 适用场景
- 微信公众号文章抓取（jina.ai 会 403，Scrapling 可以）
- 有反爬机制的网站（Medium、Substack 部分页面）
- 需要干净正文，去除页面噪音
- 批量抓取需要控制 token 成本

## 优先级策略
| 优先级 | 方案 | 适用场景 | 限制 |
|--------|------|----------|------|
| 1 | jina.ai | 大部分英文博客、Substack、Medium | 200次/天 |
| 2 | Scrapling | 微信公众号、反爬平台、需要全文 | 无限制 |
| 3 | web_fetch | 静态页面、GitHub README | 噪音多 |
| 4 | Browser | 需要登录态、极端反爬 | 最慢 |

## 微信公众号专用
微信公众号链接直接用 Scrapling，不要浪费 jina.ai 配额：
```bash
python3 /root/.openclaw/workspace/scripts/scrapling_fetch.py "https://mp.weixin.qq.com/s/xxx" 30000
```

## 注意事项
- Scrapling 返回的是 `html_content`，需要用 html2text 转换
- 不要用 `get_all_text()`，会丢失链接、图片、标题层级
- 微信公众号有验证码时可能失败
- 首次使用需要安装 playwright 浏览器驱动

## 对比我其他工具
- **jina-reader**: 适合大部分场景，快速简单
- **scrapling**: 适合微信、反爬、批量场景
- **web_fetch**: 仅适合静态页面
