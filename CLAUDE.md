# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 常用指令

```bash
yarn dev          # 啟動開發伺服器
yarn build        # 型別檢查 + 建置 (vue-tsc + vite build)
yarn build:check  # 同上（顯式型別檢查）
yarn preview      # 預覽建置結果
```

> 無測試框架，無 lint 腳本。

## 架構概覽

單頁應用程式，使用 **Vue Router** 管理頁面路由，部署於 Vercel，base 路徑為 `/ai-course/`。

### 路由結構（`src/router/index.ts`）

| 路徑 | 元件 | 說明 |
|------|------|------|
| `/` | `HomeView.vue` | 首頁，主題與投影片入口卡片 |
| `/courses` | `CoursesView.vue` | 課程列表 + 概念說明 |
| `/courses/:caseId` | `CaseDetailView.vue` | 案例詳細頁（props: `caseId`） |
| `/installation` | `InstallationSection.vue` | 5 種平台安裝說明 |
| `/openclaw` | `OpenClawUseCases.vue` | 13 分類 × 41 應用場景 |

`App.vue` 是 shell，包含 Header（點擊回首頁）、`<router-view>`（fade 動畫）、Footer。

### 資料層（`src/data/`）

所有頁面資料皆以靜態 JSON 存放，元件直接 import：

- `courses.json` — `{ modules[3], cases[8] }`
  - `cases[8]`：每個案例含 `objectives`, `requiredMCP`, `installation`, `steps`, `examplePrompts`, `troubleshooting`, `tips`, `referenceLinks`
- `installation.json` — `{ sections[5] }`（one-click-setup/macos/linux、nodejs、python）
- `openclaw-use-cases.json` — `{ categories[13] }`

**新增案例**：在 `courses.json` 的 `cases` 陣列新增一筆，`CaseDetailView` 會自動渲染。無需修改元件。

### 共用元件（`src/components/`）

- `CodeBlock.vue` — 深色程式碼區塊，支援複製、多行（`code: string | string[]`）、色彩主題（`color` prop）
- `ExternalLinks.vue` — 外部連結列表（`layout: 'vertical' | 'horizontal'`）
- `ConceptsSection.vue` — 核心概念說明段落（`CoursesView` 引用）
- `src/components/ui/` — Radix Vue 封裝的基礎元件（Card, Badge, Button, Table 等）

### 顏色系統

`CoursesView` 與 `CaseDetailView` 共用相同的 `getColorClass(color, type)` 函式，型別為 `'text' | 'bg' | 'border'`，支援：blue, green, purple, orange, indigo, teal, cyan, amber, emerald, pink, red。

### 捲動動畫

使用 `IntersectionObserver` + CSS class `scroll-animate` / `animate-in`，在 `onMounted` 後設定。各頁面元件自行管理 observer 生命週期。

### 安裝腳本（`public/`）

- `install.ps1` — Windows bootstrap，下載並執行 `install-course-env.ps1`
- `install-course-env.ps1` — Windows 完整安裝（Git、Node、Python、VS Code、UV、Claude Code、gsudo、CLAUDE.md）
- `install-mac.sh` / `install-linux.sh` — macOS / Linux 安裝腳本
- `slides.html` — Agent Skills 靜態投影片舊入口，需保留避免既有連結失效

修改平台安裝流程時，需同步更新對應腳本與 `installation.json` 的 `description` / `steps`。

### 投影片路徑規範（`public/slides/`）

新增投影片統一放在 `public/slides/<slug>/`，每份簡報使用獨立資料夾，對外網址為 `/ai-course/slides/<slug>/index.html`。

建議結構：

```text
public/slides/<slug>/
  index.html      # 簡報入口，若是 HTML 簡報必備
  slides.md       # 原始稿，若有 Markdown / Marp 來源則保留
  assets/         # 該份簡報專用圖片、附件與媒體資源
```

命名規則：

- `slug` 使用小寫英文、數字與連字號，不使用空白與中文。
- 活動型簡報優先使用日期前綴：`YYYY-MM-DD-topic`，例如 `2026-04-30-tmbdrs-ai-workflow`。
- 主題型簡報使用語意化名稱，例如 `agent-skills`。
- 每份簡報的圖片與附件放在自己的 `assets/` 或同層必要資源內，不共用跨簡報相對路徑。
- 首頁或站內入口連到 HTML 簡報時，明確使用 `index.html`，例如 `${import.meta.env.BASE_URL}slides/agent-skills/index.html`，避免目錄路徑被 Vue Router fallback 當成 SPA 路由。
- 若整理舊簡報到新路徑，只新增標準化副本，不刪除舊路徑；舊入口如 `public/slides.html`、`public/tmbdrs-2026/` 必須保留，避免外部連結失效。
