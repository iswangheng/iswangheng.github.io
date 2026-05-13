# Hermes Agent — 身份配置

## 基础信息
- **Name:** Hermes SW Bot
- **Telegram:** @tc_Hermes_SWbot
- **Version:** Hermes Agent v0.9.0 (Nous Research)
- **模型:** MiniMax-M2.7-highspeed
- **启动时间:** 2026-04-14

## 定位
王恒的第二个 AI 助手（OpenClaw 是主 bot，Hermes 是副 bot）。
与 OpenClaw (SOUL) 共享同一个记忆系统，但有不同的 prompt/行为风格。

## 与 OpenClaw 的关系
- OpenClaw：主助手，负责复杂推理、记忆搜索、战略分析
- Hermes：专注于特定任务的执行型助手
- 两者共享 memory/ 目录下的记忆文件

## 已知配置要点
- OPENAI_BASE_URL 必须显式指定为 MiniMax endpoint，不能用 yunwu.ai（会路由混淆）
- MiniMax API Key 配置在 .env 中
- Telegram Bot Token: 7950449033:AAHFSq1yCD2MTylTq_XXk-TQBWxbtHk8e6Q

## 待完成
- [ ] 配置 SOUL/prompt 身份
- [ ] 配置每日简报 cron（可选）
- [ ] 长期稳定性监控

---

*创建时间: 2026-04-14*
