# OpenClaw Windows 安裝指南 - 重點摘要

> 來源：CW 林啟維 (Portaly CEO) 撰寫的《OpenClaw 🦞 完整安裝與使用指南》v4.0
> 檔案位置：`docs/reference-materials/openclaw-windows-setup-guide-cw-v4.pdf`

---

## 核心概念

**OpenClaw 是什麼？**
- 開源自架 AI 助理，透過 Telegram 控制
- 可管理信箱、瀏覽網頁、處理檔案、執行自動化任務
- **不需要自架 AI 模型**（透過 API 連接 Claude/GPT）

**適合誰？**
- 想探索 AI 自動化的創業者
- 不需要寫程式、不需要懂 Linux
- 用於 Prototyping/POC，驗證想法後再交給工程師正式開發

---

## 硬體需求

| 項目 | 建議規格 |
|------|----------|
| CPU | Intel i3 以上（N100/N150 也能跑） |
| RAM | **16GB**（8GB 偏緊） |
| SSD | 128GB 起 |
| GPU | **完全不需要** |
| 系統 | Windows 11（需關閉 S Mode） |

**實際範例**：Acer Revo Box RB102 (i3-1305U/16GB/128GB) 約 NT$12,000-13,000

---

## 安裝流程總覽

| 步驟 | 內容 | 時間 |
|------|------|------|
| 1 | 安裝 WSL2 | 10 分鐘 |
| 2 | 修復 DNS 問題 | 5 分鐘 |
| 3 | 安裝 Node.js 22 | 5 分鐘 |
| 4 | 安裝 OpenClaw | 10 分鐘 |
| 5 | 取得 Claude API 金鑰 | 5 分鐘 |
| 6 | 建立 Telegram 機器人 | 2 分鐘 |
| 7 | 設定精靈 + 配對 | 10 分鐘 |
| 8 | 安裝技能（Skills） | 依需求 |

---

## 關鍵注意事項

### 🔴 DNS 問題（常見坑）
WSL2 預設 DNS 經常失效，**強烈建議先修復**：
```bash
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo sh -c 'echo -e "[network]\ngenerateResolvConf = false" > /etc/wsl.conf'
```
然後在 PowerShell 執行 `wsl --shutdown` 後重啟。

### 🔴 帳號安全
- 為 OpenClaw **建立獨立 Gmail**（如 yourname.assistant@gmail.com）
- Windows 上建立**獨立使用者帳號**來跑 OpenClaw
- 與主要帳號隔離，確保個人資料安全

### 🔴 API 費用
- 實際體感約 **USD $10-20/天**（依使用頻率）
- Anthropic Console 可設定**月消費上限**
- 建議從 **Claude Sonnet** 開始（速度快、相對便宜）

---

## 常見問題 FAQ

**Q: 一定要用 Mac Mini 嗎？**
> 不用。Windows PC 完全支援，本手冊以 Windows + WSL2 為主。

**Q: 需要一直接著螢幕嗎？**
> 不需要。初始設定後，所有操作透過 Telegram 完成。可用遠端桌面或 TeamViewer 連入。

**Q: 未來換電腦怎麼辦？**
> 所有資料都在 `~/.openclaw`，複製到新電腦即可完整還原。

---

## 與 Raspberry Pi 設定的比較

| 項目 | Windows (本指南) | Raspberry Pi (阿隆目前) |
|------|------------------|------------------------|
| 作業系統 | Windows 11 + WSL2 | Linux (Raspberry Pi OS) |
| 安裝難度 | 中等（需處理 WSL2） | 較簡單（純 Linux） |
| 硬體成本 | NT$12,000-15,000 | NT$3,000-5,000 |
| 功耗 | 10-15W | 5-8W |
| 穩定性 | 高 | 中等（SD 卡壽命問題） |
| 擴充性 | 可升級 RAM/SSD | 有限 |

---

## 相關連結

- 完整 PDF：`docs/reference-materials/openclaw-windows-setup-guide-cw-v4.pdf`
- OpenClaw 官網：https://docs.openclaw.ai
- 社群 Discord：https://discord.com/invite/clawd

---

*摘要建立時間：2026-02-25*
