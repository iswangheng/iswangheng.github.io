#!/bin/bash
MESSAGE=$(cat)
if [ -z "$MESSAGE" ]; then exit 1; fi
SESSION_ID="A4A024AF-ABEE-47D4-BFFE-CF270503C928"
echo "$MESSAGE" | /opt/homebrew/bin/claude -p \
 --session-id "$SESSION_ID" \
 --dangerously-skip-permissions
