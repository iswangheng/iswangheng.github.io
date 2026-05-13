# 📱 OpenClaw 手机 7×24 小时运行指南

> 适用场景：用旧 Android 手机搭建永久在线的 AI 助手
> 成本：$0（用旧手机）

---

## 📋 准备清单

| 项目 | 要求 |
|------|------|
| 手机 | Android 10+（旧手机即可） |
| 存储 | 剩余 5GB+ |
| 网络 | Wi-Fi 稳定覆盖 |
| 供电 | 长期插电 |
| API Key | Google Gemini / Claude / OpenAI |

---

## 第一步：安装 Termux

**⚠️ 重要：必须从 F-Droid 安装，不要用 Google Play**

```bash
1. 打开手机浏览器，访问 f-droid.org
2. 下载并安装 F-Droid APK
3. 打开 F-Droid，搜索 "Termux"
4. 安装 Termux
```

---

## 第二步：更新环境

打开 Termux，输入：

```bash
pkg update && pkg upgrade -y
pkg install proot-distro -y
```

---

## 第三步：安装 Ubuntu

```bash
# 安装 Ubuntu
proot-distro install ubuntu

# 进入 Ubuntu 环境
proot-distro login ubuntu
```

> 首次进入会提示创建用户，直接回车用 root 即可。

---

## 第四步：安装依赖

```bash
# 更新 Ubuntu
apt update && apt upgrade -y

# 安装必要工具
apt install curl git build-essential -y

# 安装 Node.js 22
apt install -y nodejs

# 验证
node -v
npm -v
```

---

## 第五步：安装 OpenClaw

```bash
npm install -g openclaw@latest --ignore-scripts
openclaw --version
```

---

## 第六步：修复网络问题

Android 网络接口有时会导致问题，修复：

```bash
# 创建修复脚本
cat > /root/hijack.js << 'EOF'
const os = require('os');
os.networkInterfaces = () => ({});
EOF

# 设置开机自动加载
echo 'export NODE_OPTIONS="-r /root/hijack.js"' >> ~/.bashrc
source ~/.bashrc
```

---

## 第七步：初始化配置

```bash
openclaw onboard
```

按提示完成：
1. 选择 AI 模型（推荐 Gemini 2.0 或 Claude）
2. 输入 API Key
3. 连接 Telegram/WhatsApp 等渠道

---

## 第八步：7×24 小时运行配置

### 1. 防止 Termux 被杀掉

```bash
# 安装 termux-wake-lock（保持唤醒）
termux-wake-lock
```

### 2. 设置电池不限制

```
手机设置 → 应用 → Termux → 电池 → 设为"无限制"
```

### 3. 开机自启（可选）

如果手机重启，需要手动打开 Termux 并运行：

```bash
proot-distro login ubuntu
openclaw start
```

---

## 第九步：远程访问

### 方式 A：Telegram 控制（推荐）

在手机 Termux 里：
```bash
openclaw connect telegram
```
然后用 Telegram 给 bot 发消息即可控制。

### 方式 B：Web Dashboard

```bash
openclaw dashboard
```

手机浏览器访问显示的地址。

---

## ⚠️ 常见问题

### Q1: 手机会发烫吗？

- 轻度使用（只跑 agent，不跑本地模型）：基本不发热
- 充电时轻微发热正常

### Q2: 流量消耗大吗？

- OpenClaw 纯联网运行，流量取决于使用频率
- 建议连接 Wi-Fi 使用

### Q3: 手机需要 Root 吗？

- **不需要**，Termux 不需要 Root

### Q4: 如何更新 OpenClaw？

```bash
proot-distro login ubuntu
npm update -g openclaw@latest
```

### Q5: 彻底停止运行？

```bash
# 在 Termux 里
openclaw stop

# 或者按 Ctrl+C
```

---

## 📊 性能对比

| 对比项 | 旧手机 (Pixel 4) | Mac Mini M4 |
|--------|------------------|--------------|
| 成本 | $0 | $599+ |
| 功耗 | 2-5W | 10-25W |
| 电池 | 内置 UPS | 需额外 UPS |
| 设置时间 | 10 分钟 | 30+ 分钟 |

---

## 进阶：ZeroClaw-Android（替代方案）

如果觉得 Termux 方案太复杂，可以用专用 App：

**GitHub**: https://github.com/Natfii/ZeroClaw-Android

特点：
- 一键安装
- 电池优化（Auto-restart）
- 前台服务
- API Key 加密存储

---

*更新时间：2026-03-04*
