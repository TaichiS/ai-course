# 詹嘉隆 AI Agent 實作工作坊

Claude Code 與 AI Agent 實戰課程講義網站，供上課學員隨時查閱。

## 課程簡介

本課程由詹嘉隆老師主講，以實作為導向，帶領學員從零開始掌握 AI Agent 的核心概念與應用技巧。

**適合對象：** 任何想積極運用 AI 工具提升工作效率的人，包括一般上班族、企業主、創作者、工程師等。

## 課程內容

### 基礎模組

| 模組 | 說明 |
|------|------|
| Claude Code / Gemini CLI 簡介 | AI 輔助程式開發工具概念 |
| Markdown 格式介紹 | 撰寫結構化文件的基礎語法 |

### 實作案例（8 個）

| 案例 | 主題 | 難度 |
|------|------|------|
| Case 1 | 新聞閱讀（RSS Reader MCP） | ⭐ |
| Case 2 | 購物比價神器 | ⭐ |
| Case 3 | 官方 Skill 應用 | ⭐⭐⭐ |
| Case 4 | 自動填寫表單 | ⭐⭐ |
| Case 5 | 股票投資分析 | ⭐⭐⭐⭐ |
| Case 6 | 智慧出題機器人 | ⭐⭐⭐⭐ |
| Case 7 | Notion 整合 | ⭐⭐⭐⭐ |
| Case 8 | 影音下載挑戰 | ⭐⭐⭐⭐⭐ |

### 核心概念

- **MCP Server** — Model Context Protocol，擴充 AI 工具存取能力
- **Sub Agent** — 多代理協作，分工完成複雜任務
- **Hook** — 事件觸發機制，自動化工作流程
- **Slash Commands** — 自定義斜線指令
- **Skills** — 封裝個人知識與規範的技能包
- **Plugins** — 擴充套件整合

## 技術架構

- **前端框架：** Vue 3 + TypeScript
- **樣式：** Tailwind CSS + shadcn/ui
- **建置工具：** Vite
- **部署：** GitHub Pages（透過 GitHub Actions 自動部署）

## 本機開發

```bash
# 安裝相依套件
yarn install

# 啟動開發伺服器
yarn dev

# 建置正式版本
yarn build
```

## 部署

每次 push 到 `master` 分支，GitHub Actions 會自動 build 並部署到 GitHub Pages。

首次使用需在 GitHub repo 的 **Settings → Pages** 將 Source 設為 **GitHub Actions**。

## 授權

© 2026 詹嘉隆 AI Agent 實作工作坊
