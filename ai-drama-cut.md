---
name: ai-drama-cut
version: "1.9.0"
description: 'AI 短剧智能剪辑工具。自动分析短剧视频并生成可用于投放测试的剪辑素材。V1.9.0: 修复预处理输出为空导致无法生成剪辑的关键Bug，打包补全prompts目录。'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, OpenClaw ≥1.0"
metadata:
  openclaw:
    requires:
      env: ["GEMINI_API_KEY"]
      bins: ["ffmpeg", "python3"]
    primaryEnv: GEMINI_API_KEY
  author: ai-drama-cut
  version: "1.9.0"
  repository: "http://43.163.220.15:8000/ai-drama-cut/ai-drama-cut-v1.9.0.tar.gz"
  tags:
    - video-editing
    - ai-analysis
    - drama-cutting
    - short-video
  triggers:
    - "剪辑短剧"
    - "分析短剧视频"
    - "生成短剧片段"
    - "短剧自动剪辑"
    - "AI剪辑视频"
    - "pan.baidu.com"
---

# AI 短剧智能剪辑 Skill

> 重要：以自然语言和用户沟通，不展示命令行日志、错误堆栈或安装细节。重点是让用户始终知道系统正在做什么、已经完成什么、下一步是什么。

## Skill 契约

这个 skill 的承诺以运行时可稳定兑现为准，核心保证有五类：

1. 开始前会给出执行计划
   - 说明项目名、是否预处理、预计生成数量、主要阶段。
2. 最佳努力主动汇报进展，让用户有掌控感
   - 优先通过短命令 progress relay 查询并转述最新状态，而不是依赖长命令 stdout 流式送达。
   - 渲染阶段分批执行，每批完成后主动汇报已完成数量和新生成的文件。
   - 若宿主支持后台任务后的定时再次调用，可持续主动汇报；否则降级为“后台执行 + 可查询最新进度 + 下次可运行时补发最新状态”。
3. 每个阶段都会有状态更新
   - 预处理、分析、渲染都会输出阶段状态。
4. 长任务会有 heartbeat / stale 治理
   - `last_progress_at` 只代表真实推进，`updated_at` 代表进程仍在活动。
   - relay 会区分 fresh running、stale but alive、orphaned stale，避免把残留进度误报成仍在运行。
5. 失败时会给出恢复信息
   - 说明失败分类、已完成阶段、保留的中间结果、建议下一步。

以下内容不再作为硬保证：
- 不承诺一定能自动修复所有安装失败。
- 不承诺一定能把生成文件直接发送给用户。
- 不承诺 ETA 绝对精确，ETA 只用于降低不确定感。
- 不承诺长命令 stdout 一定会被宿主实时转发到用户对话。

## 识别百度网盘链接

当用户消息中包含 `pan.baidu.com/s/` 时，视为下载请求：
- 自动提取链接和提取码
- 提取码可能在 URL 参数中（`?pwd=abcd`）、在同一消息中（”提取码: abcd”、”提取码：abcd”）、或在后续消息中
- 如果缺少提取码，向用户索要

链接格式示例：
- `https://pan.baidu.com/s/1xxx?pwd=abcd`（URL 自带提取码）
- `https://pan.baidu.com/s/1xxx 提取码: abcd`（文本中包含提取码）
- `链接: https://pan.baidu.com/s/1xxx 提取码: abcd`（带前缀）

## 用户交互准则

当用户问”怎么剪辑””怎么使用”时：
- 不解释底层命令和技术细节。
- 直接引导用户提供百度网盘分享链接（最简单）或本地视频目录。
- 用自然语言说明会自动完成下载、分析、剪辑、花字、片尾和结果汇总。

可使用的简短回复模板：

“你只需要把短剧的百度网盘分享链接发给我就行，我会自动下载、分析、剪辑，全程不用你操作。

具体来说：
1. 你发百度网盘链接（带提取码）
2. 我自动下载视频 → AI 分析高光和钩子点 → 渲染剪辑视频 → 上传成品到百度网盘
3. 每一步完成我都会告诉你进展，最后把成品的网盘链接发给你

如果视频已经在本地，告诉我目录路径也行。”

## 使用流程

### 1. 安装

```bash
cd openclaw
bash install.sh
python check_dependencies.py
```

### 2. 配置 API Key

```bash
python setup_api.py
```

### 3. 执行（后台启动 + 循环查进度）

> **核心规则：pipeline 自己驱动，Agent 不需要编排步骤。** pipeline 内部自动串联所有阶段（预处理 → 分析 → 分批渲染 → 上传），每个阶段完成后自动进入下一步。Agent 只需后台启动 pipeline，然后循环查进度并汇报给用户。

**步骤 1：获取当前对话信息**

启动 pipeline 前，先确定当前对话的渠道和目标 ID，用于 pipeline 主动推送进度到对话中：
- 飞书群聊：`--notify-channel feishu --notify-target "<chat_id>"`
- Telegram：`--notify-channel telegram --notify-target "<chat_id>"`
- 其他渠道类似

> **如何获取 chat_id**：你当前正在和用户对话，对话的 channel 和 chat_id 信息在你的上下文中。飞书群聊的 chat_id 格式通常是 `oc_xxxxxxxx`。

**步骤 2：后台启动 pipeline（带 --notify 参数）**

```bash
# 标准流程（飞书群聊推送进度）
exec background=true python skill.py --input "漫剧素材/项目名" --upload --notify-channel feishu --notify-target "<chat_id>"

# 带百度网盘下载
exec background=true python skill.py --download-url "https://pan.baidu.com/s/1xxx?pwd=abcd" --upload --notify-channel feishu --notify-target "<chat_id>"

# 跳过预处理
exec background=true python skill.py --input "漫剧素材/项目名" --skip-preprocess --upload --notify-channel feishu --notify-target "<chat_id>"
```

启动后**立即告诉用户已开始**。pipeline 会在每个阶段完成时自动往对话中推送进度消息，**不需要你额外做任何事情**。

> **注意**：项目名是输入目录的最后一段。如 `--input "漫剧素材/复婚"` 的项目名是 `复婚`。百度网盘下载时，项目名是下载后的短剧名。

**Pipeline 会自动推送的消息示例：**
```
🔄 预处理中：扫描和处理敏感内容...
🔄 预处理完成。进入 AI 分析阶段...
🔄 AI 分析完成。11 集，11 个高光点、23 个钩子点，20 个剪辑组合。进入渲染阶段...
🔄 渲染第 1/4 批（第 1-5 条）...
🔄 第 1 批渲染完成（5/20 条）。
🔄 渲染第 2/4 批（第 6-10 条）...
...
🎉 全部完成！项目: 复婚，生成 20 条剪辑视频，总大小 2340 MB，耗时 25分30秒。
```

**如果无法获取 chat_id**：可以不传 `--notify-channel` 和 `--notify-target`，改用手动轮询：

```bash
# 后台启动（不带 notify）
exec background=true python skill.py --input "漫剧素材/项目名" --upload

# 手动查进度（每次瞬间返回）
exec sleep 30 && python skill.py --progress-status "项目名"
# 转述给用户，然后再查下一次，直到看到"暂无正在运行的任务"
```

## 进度送达规则

### 主契约：pipeline 主动推送（--notify-channel + --notify-target）

当传入 `--notify-channel` 和 `--notify-target` 时，pipeline 会在每个阶段完成时**自动调用 `openclaw message send` 往对话中推送进度**。Agent 不需要做任何额外工作。

这是最可靠的方式，因为推送由 pipeline 代码控制，不依赖 Agent 的调度能力。

### 降级方案：手动轮询

如果无法获取 chat_id（无法传 --notify 参数），Agent 需要手动查进度：

```bash
sleep 30 && python skill.py --progress-status “项目名”
```

每次查完转述给用户，重复直到看到”暂无正在运行的任务”。

### 备用命令

```bash
python skill.py --progress-tick “复婚”       # JSON 格式，是否有新消息
python wait_and_report.py --project “复婚”   # 本地调试用的阻塞式轮询
```

### 进度状态语义

- `fresh_running`：最近有真实推进，`last_progress_at` 与 `updated_at` 都较新。
- `stale_but_alive`：最近没有真实推进，但进程仍在 heartbeat，`updated_at` 继续刷新。
- `orphaned_stale`：`updated_at` 也已过旧，说明大概率是上一次异常退出留下的残留状态。

### 进度汇报原则

`--progress-status` 的输出来自 `check_progress.py`，已包含正确的阶段名、数量和单位。Agent 汇报时**直接转述**，**严禁自己编造进度数字或单位**。

输出示例：
- 运行中：`📊 复婚 - AI 分析：15/50个片段 (30.0%)，当前：第8集 120.0-180.0秒。预计剩余约 5-8 分钟（已运行 3分20秒）`
- 停滞但进程仍存活：`📊 复婚 - AI 分析：15/50个片段 (30.0%)，当前：第8集。预计剩余约 5 分钟（已运行 5分00秒）  ⚠️ 已 2分30秒 无真实推进，但最近仍有 heartbeat`
- 残留状态：`📊 复婚 - AI 分析：15/50个片段 (30.0%)。预计剩余约 5 分钟（已运行 5分00秒）  ⚠️ 该进度已离线 4分10秒，疑似上次残留状态`
- 无任务：`⏳ 复婚：暂无正在运行的任务。`

### orphaned 残留治理

宿主或维护脚本可以定期检查并清理异常残留的 `.progress` 文件：

```bash
python skill.py --list-orphaned-progress
python skill.py --cleanup-orphaned-progress
```

输出示例：
- 列出残留：`⚠️ 发现 2 个 orphaned .progress 残留文件：...`
- 清理完成：`🧹 已清理 2 个 orphaned .progress 残留文件：...`
- 无残留：`✅ 没有发现 orphaned .progress 残留文件。`

> `--cleanup-orphaned-progress` 只清理已判定为 `orphaned_stale` 的残留文件，不会删除 fresh running 或 stale but alive 的正在运行任务。

## 运行时行为

### 进度转述（最重要的交互原则）

**传了 --notify 参数时**：pipeline 自动推送进度到对话中，Agent 无需额外操作。如果用户问进度，直接说"系统会自动推送进度到这里，请稍等"。

**没传 --notify 参数时**：Agent 需要主动循环查 `--progress-status` 并转述给用户。不要等用户来问。

### 开始阶段

开始时会输出一段简短计划，至少包含：
- 项目名
- 输入目录
- 是否启用预处理
- 预计阶段
- 预计输出数量

### 阶段更新

运行时会持续输出：
- 当前阶段
- 当前对象（例如第几集、第几个片段、第几个 clip）
- 已完成数量 / 总量
- 简短说明

### Heartbeat

如果某个阶段较慢，系统不会沉默。

典型 heartbeat 类似：
- “仍在进行 AI 分析，当前处理第 8/11 集。”
- “仍在渲染，当前编码 clip 3/5。”

### 完成摘要

结束时会输出统一摘要，至少包含：
- 成功生成的 clip 数量
- 总耗时
- 输出目录
- 推荐优先查看的结果
- 百度网盘分享链接和提取码（如已配置）

### 视频交付（百度网盘）

渲染完成的视频通过百度网盘交付给用户，避免飞书 20MB 文件大小限制。

**工作流程**：
1. 每批渲染完成后，agent 先汇报渲染结果
2. 然后执行 `--upload-only` 命令，上传当前所有已渲染的视频到百度网盘
3. 上传完成后 agent 汇报上传结果和分享链接
4. 用户点击链接即可在线查看视频

> **关键**：渲染和上传必须是两条独立命令，这样 agent 在两步之间都能主动 push 消息到 channel，用户始终知道进展。

**前提条件**：
- 需要配置 `BAIDU_BDUSS` 和 `BAIDU_STOKEN` 环境变量
- 如果未配置，上传会提示未配置并跳过，不影响渲染流程

**上传完成后 agent 汇报示例**：
> ✅ 已上传 5 个视频到百度网盘（共 420 MB）
> 📎 分享链接: https://pan.baidu.com/s/1xxxx
> 🔑 提取码: abcd（7天有效）

### 失败摘要

失败时会输出：
- 失败阶段
- 失败分类：环境 / 输入 / 资源 / 外部 API / 内部异常
- 已完成阶段
- 是否保留中间结果
- 可直接重试的建议

## Resume 与恢复

该 skill 优先提供“软 resume”能力，而不是完整 checkpoint 引擎。

可复用的内容包括：
- `data/cache/keyframes`
- `data/cache/asr`
- `data/cache/subtitle_region`
- `data/analysis/<项目名>/result.json`
- 自动修复旧 `result.json`

如果检测到已有中间结果，运行时会明确告知：
- 哪些阶段会跳过
- 哪些阶段会继续
- 本次是否从已有分析或缓存继续

## 输出目录

默认输出到：
- macOS / Linux: `clips/<项目名>/`
- Windows: `%USERPROFILE%\Documents\AI-Drama-Cut\clips\<项目名>\`

## 故障处理原则

遇到错误时：
1. 优先给用户可理解的状态说明，不沉默。
2. 尝试复用已有缓存和中间结果。
3. 只在确有必要时请求用户配合，例如补 API Key、释放磁盘空间、检查输入路径。
4. 不向用户倾倒原始堆栈和安装日志。

## 安装指南

### 系统要求
- **Python**: 3.10 或更高版本（编译模块依赖）
- **FFmpeg**: 支持视频处理和文本叠加
- **磁盘空间**: 建议 10GB+（视频缓存和渲染输出）
- **API Key**: Google Gemini API Key（用于AI分析）

### 快速安装

#### 1. 下载并解压
```bash
# 下载 skill 包
wget http://43.163.220.15:8000/ai-drama-cut/ai-drama-cut-v1.9.0.tar.gz

# 或使用 curl
curl -O http://43.163.220.15:8000/ai-drama-cut/ai-drama-cut-v1.9.0.tar.gz

# 升级前清理旧编译文件（重要！旧 .so 会覆盖新 .py）
find scripts/ -name "*.cpython-*.so" -delete 2>/dev/null

# 解压
tar -xzf ai-drama-cut-v1.9.0.tar.gz
cd ai-drama-cut-v1.9.0
```

#### 2. 运行安装脚本（自动配置环境）
```bash
# 自动安装所有依赖
bash openclaw/install.sh
```

**安装脚本会自动**：
- ✅ 检查 Python 版本（要求 3.10+）
- ✅ 检测 FFmpeg 是否安装
- ✅ 安装 Python 依赖包
- ✅ 配置虚拟环境（如需要）

#### 3. 配置 API Key
```bash
python openclaw/setup_api.py
# 输入你的 Gemini API Key
```

### 依赖来源说明

**Python 依赖**（通过 pip 安装）：
- 来自 PyPI 官方源
- 使用清华大学镜像加速（中国区）
- 自动处理版本兼容性

**FFmpeg**（视频处理）：
- macOS: `brew install ffmpeg`
- Linux: `sudo apt install ffmpeg` 或 `yum install ffmpeg`
- 需要启用 `--enable-libfreetype` 和 `--enable-libfontconfig`

**可选依赖**（功能增强）：
- PyTorch: GPU 加速（可选）
- PaddlePaddle: OCR 功能

### 版本兼容性

**Python 版本**：
- ✅ Python 3.10.x - 推荐
- ⚠️ Python 3.9.x - 不兼容编译模块
- ❌ Python 3.8 及以下 - 不支持

**操作系统**：
- ✅ macOS 11+ (Intel + Apple Silicon)
- ✅ Ubuntu 20.04+ / CentOS 7+
- ⚠️ Windows - 需要 WSL2

### 故障排除

**问题 1: Python 版本不兼容**
```bash
# 检查 Python 版本
python3 --version

# 如果是 3.9 或更低，升级 Python
# macOS:
brew install python@3.10

# Linux:
sudo apt install python3.10
```

**问题 2: FFmpeg 缺失**
```bash
# macOS:
brew install ffmpeg

# Linux:
sudo apt install ffmpeg
```

**问题 3: 编译模块加载失败**
```bash
# 确认 Python 版本
python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"

# 如果是 3.9 或更低，需要升级
```

### 验证安装

```bash
# 检查依赖
python openclaw/check_dependencies.py

# 测试导入
python -c "from openclaw.skill import AIDramaCutter; print('✅ 导入成功')"
```

