# 用 Telegram 遠端控制 Claude Code

> 設定完成後，你可以在任何地方用手機傳訊息給 Claude Code，讓它在你的電腦上執行任務、讀寫檔案、回報進度。

---

## 你需要準備什麼

- 已安裝 Claude Code（會在終端機執行 `claude`）
- 一個 Telegram 帳號
- 約 10 分鐘

---

## Step 1｜在 Telegram 建立你的 Bot

1. 打開 Telegram，搜尋 **@BotFather**
2. 對它發送 `/newbot`
3. BotFather 會依序問你兩件事：

   **第一個問題：Bot 的名稱（顯示名稱）**
   這是別人看到的名字，可以用中文、有空格都沒關係。
   例如：`我的 Claude`

   **第二個問題：Bot 的帳號 ID（username）**
   這是用來搜尋這個 bot 的唯一識別碼，規則如下：
   - 只能用英文字母、數字、底線
   - **必須以 `bot` 結尾**，例如 `my_claude_bot`
   - 全 Telegram 唯一，不能跟別人重複

   > ⚠️ **大部分簡短有意義的名稱都已經被取走了。**
   > 建議在前面加上個人識別字，例如姓名縮寫或數字：
   > `drchen_claude_bot`、`james2026_bot`

4. 成功後，BotFather 會回給你一組 **Token**，格式長這樣：
   ```
   123456789:AAHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
   ```
   **把這串複製起來，Step 3 會用到。**

---

## Step 2｜在 Claude Code 安裝 Telegram 插件

打開終端機，啟動 Claude Code，輸入：

```
/plugin install telegram@claude-plugins-official
```

安裝完後輸入：

```
/reload-plugins
```

看到類似「Reloaded: 16 plugins...」就代表安裝成功。

---

## Step 3｜把 Token 存入 Claude Code

輸入以下指令（把 `<你的token>` 換成剛剛複製的那串）：

```
/telegram:configure <你的token>
```

例如：
```
/telegram:configure 123456789:AAHxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Claude Code 會把 token 安全地存到 `~/.claude/channels/telegram/.env`。

---

## Step 4｜用 Channels 模式重新啟動

**完全退出** 目前的 Claude Code，然後用這個指令重新啟動：

```
claude --channels plugin:telegram@claude-plugins-official --permission-mode bypassPermissions
```

> ⚠️ 這個步驟很關鍵。只裝插件、不用 `--channels` 重啟，Telegram 功能不會生效。
>
> `--permission-mode bypassPermissions` 是必要的，省略這個參數的話，Claude Code 每次執行操作都會停下來詢問你是否同意，而你在手機端無法回應，對話就會卡住。

### 進階：替換成其他廠商的模型

如果想把底層模型換成非 Anthropic 的服務（例如 Kimi、DeepSeek 等），
可以在啟動前用環境變數覆蓋 API 端點與金鑰：

```bash
export ANTHROPIC_AUTH_TOKEN="你的API金鑰" && \
export ANTHROPIC_BASE_URL="https://該服務的API網址" && \
CLAUDE_CODE_NO_FLICKER=1 claude --channels plugin:telegram@claude-plugins-official --permission-mode bypassPermissions
```

- `ANTHROPIC_AUTH_TOKEN`：替換成該服務核發給你的 API 金鑰
- `ANTHROPIC_BASE_URL`：替換成該服務相容 Anthropic API 格式的端點網址
- `CLAUDE_CODE_NO_FLICKER=1`：停用畫面重繪，避免在本機終端機上下捲動時畫面閃爍或亂跳

> 支援的前提是：該服務必須提供與 Anthropic API 相容的介面格式。

---

## Step 5｜配對你的 Telegram 帳號

1. 在 Telegram 找到你剛建立的 bot（搜尋你設定的帳號名稱）
2. 傳任意訊息給它，例如 `你好`
3. Bot 會回覆一組 **6 碼配對碼**，例如 `A3F9K2`

回到 Claude Code 終端機輸入：

```
/telegram:access pair A3F9K2
```

（把 `A3F9K2` 換成你收到的那組碼）

---

## Step 6｜鎖定安全政策（建議）

配對成功後，建議把存取模式鎖定，避免其他人觸發配對：

```
/telegram:access policy allowlist
```

完成後，只有已配對的帳號才能跟你的 Claude Code 溝通。

---

## 開始使用

現在可以直接在 Telegram 對你的 bot 傳訊息，例如：

- `幫我列出桌面上所有的檔案`
- `把桌面上的 report.pdf 摘要一下`
- `現在幾點了？`

Claude Code 會在你的電腦上執行，結果會透過 Telegram 回傳給你。

---

## Telegram vs QR Code 遠端模式比較

Claude Code 有兩種遠端操作方式，差異如下：

| | QR Code（官方 App） | Telegram Channel |
|--|---|---|
| **連線方式** | 掃 QR Code，用 Claude 官方手機 App | 透過自建 Telegram Bot |
| **可用模型** | 僅限 Anthropic 官方模型（Claude） | **可替換成任何相容模型** |
| **上手難度** | 極簡，掃碼即用 | 需要設定 bot，約 10 分鐘 |
| **彈性** | 低 | 高 |

**Telegram Channel 的模型彈性** 是它最大的優勢。
Claude Code 本身支援替換底層模型，透過 Telegram channel 操作時，你可以把模型換成：

- **Kimi**（月之暗面，適合長文本）
- **MiniMax**（擅長中文對話）
- **GLM**（智譜 AI）
- **DeepSeek**（性價比高，開源友善）

對需要控制成本、或想嘗試不同模型特性的使用者來說，這是 QR Code 模式做不到的。

---

## 傳送圖片

| 傳法 | 結果 |
|------|------|
| 直接傳照片 | Telegram 會壓縮，畫質下降 |
| 長按 → **以檔案傳送** | 原始畫質，適合傳圖表或論文截圖 |

---

## 注意事項

- **離線時送出的訊息會消失**，沒有排隊機制，Claude Code 沒在跑就收不到
- Bot 看不到歷史訊息，只能收到即時到達的內容
- **每次重新啟動 Claude Code，對話記憶都會清空**，它不會記得上一次的對話內容
- Token 是敏感資訊，請勿分享給他人

---

## 常見問題

**Bot 沒有回應？**
確認 Claude Code 是用 `--channels plugin:telegram@claude-plugins-official` 啟動的，不是一般的 `claude`。

**配對碼輸入後說無效？**
配對碼有時效，請重新傳訊息給 bot 取得新碼。

**想讓別人也能用同一個 bot？**
請他們傳訊息給 bot 取得配對碼，你再用 `/telegram:access pair <code>` 批准。
全部人都加入後記得執行 `/telegram:access policy allowlist` 鎖定。
