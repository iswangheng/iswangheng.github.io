#!/bin/bash
# 更新 Evolution 页面统计数字

cd /root/.openclaw/workspace

# 统计数据
RULES=$(grep -c "^## " memory/learned-rules.md 2>/dev/null || echo "0")
LOGS=$(grep -c "^## 2026" memory/evolution-log.md 2>/dev/null || echo "0")
INSIGHTS=$(grep -c "^## " memory/insights.md 2>/dev/null || echo "0")
DATE=$(date '+%Y-%m-%d %H:%M')

echo "统计结果："
echo "- 规则数: $RULES"
echo "- 进化记录: $LOGS"
echo "- Insights: $INSIGHTS"
echo "- 更新时间: $DATE"

# 更新 evolution/index.html
sed -i "s/<div class=\"stat-value\">[0-9]*<\/div>/<div class=\"stat-value\">$RULES<\/div>/" evolution/index.html
sed -i "s/<div class=\"stat-value\">每.*<\/div>/<div class=\"stat-value\">每12小时<\/div>/" evolution/index.html
sed -i "s/<div class=\"stat-value\">[0-9]*<\/div>/<div class=\"stat-value\">$LOGS<\/div>/" evolution/index.html

# 更新首页 index.html
sed -i "s/<strong>[0-9]*<\/strong> 条规则/<strong>$RULES<\/strong> 条规则/" index.html
sed -i "s/<strong>[0-9]*<\/strong> 次进化/<strong>$LOGS<\/strong> 次进化/" index.html
sed -i "s/最后更新 [0-9-]*/最后更新 $(date '+%Y-%m-%d')/" index.html

# 同步文件
cp memory/evolution-log.md evolution/
cp memory/learned-rules.md evolution/
cp memory/insights.md evolution/

# Git 提交
git add evolution/index.html evolution/*.md index.html
git commit -m "Update evolution stats: $RULES rules, $LOGS logs ($DATE)"
git push

echo "✅ 已更新并推送到 GitHub Pages"
