# 2026-05-20 ICEET 讓 AI 成為你的數位特助 投影片維護筆記

**場合：** 中華資訊與科技教育學會 ICEET 2026 國際研討會 工作坊
**日期：** 2026-05-20
**對象：** 教師、教育學者、研究者（非技術背景）
**主題：** 讓 AI 成為你的數位特助

這份簡報是單一 HTML 投影片，主要檔案為 `index.html`。每一頁都以 `<section>` 表示，並透過 `data-screen-label` 標記方便定位。

## 快速定位某一頁

定位某頁：

```bash
rg 'data-screen-label="31' public/slides/2026-05-20-iceet-ai-assistant/index.html
```

搜尋所有頁碼標籤：

```bash
rg 'data-screen-label=' public/slides/2026-05-20-iceet-ai-assistant/index.html
```

## 修改原則

- 優先只修改目標 slide 的 `<section>` 與附近局部 `<style>`。
- 若新增只屬於單頁的動畫或樣式，建議放在該 slide 後方，避免影響其他頁。
- 維持 `data-screen-label="XX 標題"` 同步，之後才容易搜尋。
- 圖片、icon、附件放在本資料夾內的 `assets/` 或 `icons/`，並使用相對路徑。
- 對外連結請使用 `index.html`，例如 `/ai-course/slides/2026-05-20-iceet-ai-assistant/index.html`。

## 目前路徑

- 簡報入口：`public/slides/2026-05-20-iceet-ai-assistant/index.html`
- 圖示：`public/slides/2026-05-20-iceet-ai-assistant/icons/`
- 對外網址：`/ai-course/slides/2026-05-20-iceet-ai-assistant/index.html`

## 本版與原版（04-30 TMBDRS）差異

| 項目 | 04-30 TMBDRS（醫師版） | 05-20 ICEET（教育版） |
|------|----------------------|----------------------|
| 主標題 | 用 Claude Code 重塑知識流與工作流 | 讓 AI 成為你的數位特助 |
| 主辦 | 台灣醫學大數據研究學會 | 中華資訊與科技教育學會 |
| 對象 | 醫師 | 教師、學者、研究者 |
| Slide 09 | 對醫師的意義 | 對教育工作者的意義 |
| Slide 16 | 病患資料安全 | 學生資料安全 |
| Slide 21 示範 | 唐詩三百首 10 個 txt | 建立備課素材資料夾 |
| Slide 32 Obsidian | 臨床觀察 / 病歷 | 備課筆記 / 教案設計 |
| Slide 37 Skills | 論文摘要、病歷整理、衛教草稿、研究設計 | 學術文獻摘要、備課整理、學生回饋草稿、研究計畫審查 |
| 封面圖示 | 聽診器、心電圖、病歷、藥瓶 | 📚 🔬 📝 🎓 |
