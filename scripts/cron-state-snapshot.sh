#!/bin/bash
# cron-state-snapshot.sh - 每日 Cron 状态快照生成器
# 由每日反思仪式调用（或独立运行）
# 输出: memory/cron-snapshots/YYYY-MM-DD.json

OUTPUT_DIR="/root/.openclaw/workspace/memory/cron-snapshots"
# 使用北京时间（与 cron 任务时区一致）
DATE=$(TZ='Asia/Shanghai' date +%Y-%m-%d)
OUTPUT_FILE="${OUTPUT_DIR}/${DATE}.json"

mkdir -p "$OUTPUT_DIR"

# 获取所有 cron job 状态 (JSON 格式)
CRON_STATUS=$(openclaw cron list --json 2>/dev/null | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    jobs = data.get('jobs', [])
    
    # 筛选关键信息
    summary = []
    for j in jobs:
        if not j.get('enabled', False):
            continue
        state = j.get('state', {})
        summary.append({
            'name': j.get('name', 'unknown'),
            'id': j.get('id', ''),
            'lastRunStatus': state.get('lastRunStatus', 'unknown'),
            'lastStatus': state.get('lastStatus', 'unknown'),
            'lastRunAtMs': state.get('lastRunAtMs', 0),
            'lastDurationMs': state.get('lastDurationMs', 0),
            'consecutiveErrors': state.get('consecutiveErrors', 0),
            'lastDelivered': state.get('lastDelivered', False),
        })
    
    # 统计
    total = len(summary)
    ok = sum(1 for s in summary if s['lastRunStatus'] == 'ok')
    error = sum(1 for s in summary if s['lastRunStatus'] == 'error')
    no_run = sum(1 for s in summary if s['lastRunStatus'] not in ['ok', 'error'])
    errors_ce = sum(1 for s in summary if s['consecutiveErrors'] > 0)
    
    print(json.dumps({
        'date': '$DATE',
        'generatedAt': $(TZ='Asia/Shanghai' date +%s),
        'stats': {
            'total': total,
            'ok': ok,
            'error': error,
            'noRun': no_run,
            'consecutiveErrors': errors_ce
        },
        'jobs': summary
    }, indent=2))
except Exception as e:
    print(json.dumps({'error': str(e)}))
" 2>/dev/null)

if [ -n "$CRON_STATUS" ]; then
    echo "$CRON_STATUS" > "$OUTPUT_FILE"
    echo "✅ Cron 快照已保存: $OUTPUT_FILE"
    
    # 额外：检查今天的 evolution-log 条目数（北京时间）
    EVO_TODAY=$(grep -c "^## $(TZ='Asia/Shanghai' date +%Y-%m-%d)" /root/.openclaw/workspace/evolution-log.md 2>/dev/null || echo "0")
    echo "📊 今日 evolution-log 条目: $EVO_TODAY"
    
    # 检查是否有红灯（consecutiveErrors > 0）
    RED_COUNT=$(echo "$CRON_STATUS" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    print(data['stats']['consecutiveErrors'])
except:
    print(0)
" 2>/dev/null)
    
    if [ "$RED_COUNT" -gt 0 ]; then
        echo "⚠️ 警告: $RED_COUNT 个任务有 consecutiveErrors"
    else
        echo "✅ 全部 cron 任务无红灯"
    fi
else
    echo "❌ 无法获取 cron 状态"
    exit 1
fi
