# 2026-04-30 TMBdRS AI Workflow 投影片維護筆記

這份簡報是單一 HTML 投影片，主要檔案為 `index.html`。每一頁都以 `<section>` 表示，並透過頁碼註解與 `data-screen-label` 標記方便定位。

## 快速定位某一頁

第 N 頁通常可以用兩種標記找到：

```html
<!-- SLIDE 31 · Obsidian 是什麼 + 天作之合 -->
<section data-screen-label="31 Obsidian 天作之合">
```

定位第 31 頁：

```bash
rg 'SLIDE 31|data-screen-label="31' public/slides/2026-04-30-tmbdrs-ai-workflow/index.html
```

如果只記得頁面關鍵字，也可以直接搜尋文字：

```bash
rg 'Obsidian|臨床觀察|論文閱讀筆記' public/slides/2026-04-30-tmbdrs-ai-workflow/index.html
```

## 修改原則

- 優先只修改目標 slide 的 `<section>` 與附近局部 `<style>`。
- 若新增只屬於單頁的動畫或樣式，建議放在該 slide 後方，避免影響其他頁。
- 維持 `SLIDE XX` 註解與 `data-screen-label="XX 標題"` 同步，之後才容易搜尋。
- 圖片、icon、附件放在本資料夾內的 `assets/` 或 `icons/`，並使用相對路徑。
- 對外連結請使用 `index.html`，例如 `/ai-course/slides/2026-04-30-tmbdrs-ai-workflow/index.html`。

## 常用指令

搜尋某頁：

```bash
rg 'SLIDE 31|data-screen-label="31' public/slides/2026-04-30-tmbdrs-ai-workflow/index.html
```

搜尋所有頁碼標籤：

```bash
rg 'data-screen-label=' public/slides/2026-04-30-tmbdrs-ai-workflow/index.html
```

啟動本機預覽：

```bash
yarn dev
```

建置檢查：

```bash
yarn build
```

## 目前路徑

- 簡報入口：`public/slides/2026-04-30-tmbdrs-ai-workflow/index.html`
- 圖示：`public/slides/2026-04-30-tmbdrs-ai-workflow/icons/`
- 對外網址：`/ai-course/slides/2026-04-30-tmbdrs-ai-workflow/index.html`
