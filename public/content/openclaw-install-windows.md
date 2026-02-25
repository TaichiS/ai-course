# OpenClaw Windows 安裝指南（WSL）

## 前置需求

- Windows 10 版本 2004 及以上（建議 Windows 11）
- 系統管理員權限

---

## 步驟一：檢查 WSL 狀態

開啟 PowerShell（系統管理員），執行：

```powershell
wsl --version
```

**預期輸出：**
```
WSL 版本：2.x.x.x
核心版本：5.x.x
WSLg 版本：1.x.x
MSRDC 版本：1.x.x
Direct3D 版本：1.x.x
DXCore 版本：10.x.x
Windows 版本：10.x.x
```

---

## 步驟二：安裝 WSL

如果 WSL 尚未安裝，執行：

```powershell
wsl --install
```

**安裝過程會：**
1. 啟用 WSL 功能
2. 啟用虛擬機平台
3. 下載並安裝 Ubuntu

**安裝完成後請重新啟動電腦。**

---

## 步驟三：設定 Ubuntu

重新開機後，Ubuntu 會自動啟動，請設定：

```
Enter new UNIX username: your_username
New password: your_password
Retype new password: your_password
```

> ⚠️ 輸入密碼時畫面不會顯示任何字元，這是 Linux 正常行為，直接輸入按 Enter 即可。

**請記住這組帳號密碼！**

---

## 步驟四：修復 WSL2 的 DNS 問題

> 🚨 **這是實際安裝中最常踩到的第一個坑。** WSL2 預設的 DNS 設定經常失效，導致後續所有套件下載和網路連線都會失敗。強烈建議在安裝任何東西之前先處理。

測試 DNS 是否正常：

```bash
ping -c 2 google.com
```

如果出現 `Temporary failure in name resolution` 或 `name resolution` 相關錯誤，依序執行以下修復：

```bash
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
sudo sh -c 'echo -e "[network]\ngenerateResolvConf = false" > /etc/wsl.conf'
```

然後在 **Windows 的 PowerShell** 執行：

```powershell
wsl --shutdown
```

重新開啟 Ubuntu，再測試一次 `ping -c 2 google.com`，確認可以正常連線再繼續。

---

## 步驟五：安裝 Node.js 22

OpenClaw 需要 Node.js 22 以上版本，Ubuntu 預設版本太舊，需要手動安裝：

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

驗證版本：

```bash
node --version
```

應顯示 `v22.x.x` 或更高版本。

---

## 步驟六：設定 sudo 免密碼

為了讓 OpenClaw 能順利運作，需要設定 sudo 免密碼：

```bash
sudo visudo
```

**編輯器操作：**
1. 使用方向鍵移動到檔案最下方
2. 新增一行：
   ```
   your_username ALL=(ALL) NOPASSWD: ALL
   ```
   （將 `your_username` 換成你的使用者名稱）
3. 按 `Ctrl + O` 儲存
4. 按 `Enter` 確認檔名
5. 按 `Ctrl + X` 離開

---

## 步驟七：安裝 OpenClaw

> ⚠️ **名稱更新提醒：** 專案經歷多次改名（Clawdbot → Moltbot → OpenClaw）。正確的安裝方式是 `npm install`，不是 getclaw.dev 的舊安裝腳本。

```bash
npm install -g openclaw
```

安裝完成後執行 `openclaw` 啟動設定精靈。選擇 **QuickStart**，技能（Skills）先選 **Skip**，後續步驟十一再安裝。

---

## 步驟八：驗證安裝

安裝完成後，重新開啟 WSL 終端機，執行：

```bash
openclaw --version
```

**預期輸出：**
```
openclaw version x.x.x
```

---

## 步驟九：啟動 OpenClaw

```bash
openclaw gateway start
```

或使用互動模式：

```bash
openclaw
```

---

## 步驟十：取得 Claude API 金鑰

1. 前往 **console.anthropic.com** 註冊帳號

   > 注意：這和 claude.ai 是**不同的帳號系統**，需要分開註冊

2. 左側選單 → **API Keys** → **Create Key** → 命名為 `OpenClaw` → 立即複製並保存

3. 前往 **Billing** 頁面加入信用卡，並設定**月消費上限**

> ⚠️ **金鑰只顯示一次，關掉視窗後無法再查看，遺失只能重新建立新金鑰。**

**模型選擇建議：**

| 模型 | 特性 | 建議用途 |
|------|------|----------|
| claude-sonnet-4-5 | 速度快、費用相對低 | 日常使用首選 |
| claude-opus-4-5 | 能力最強、費用較高 | 複雜任務 |

實際費用約 USD $10–20/天，密集使用時會更高，務必在 Anthropic Console 持續監控使用量，避免意外帳單。

---

## 步驟十一：建立 Telegram 機器人

1. 在 Telegram 搜尋 **@BotFather** → 點選 `/start` → 輸入 `/newbot`
2. 依提示設定機器人名稱和 username（username **必須以 bot 結尾**）
3. 保存 BotFather 回覆的 **Token**

同時取得你的 User ID（用來限制只有你能控制這個 bot）：

4. 搜尋 **@userinfobot** → 點選 `/start` → 記下回傳的**數字 User ID**

> 🚨 **Bot Token 等於機器人的密碼，絕對不要公開或傳給任何人。** 如果不慎洩漏，立刻回到 BotFather 執行 `/revoke` 重新產生。

---

## 步驟十二：設定精靈 + Telegram 配對

在 OpenClaw 設定精靈中依序選擇：

1. AI 提供者選 **Anthropic / Claude**
2. 貼上步驟十取得的 **Claude API 金鑰**
3. 通訊管道選 **Telegram (Bot API)**
4. 貼上步驟十一取得的 **Bot Token**

**完成 Telegram 配對：**

1. 在 Telegram 上找到你剛建立的 bot → 按 **Start** → 傳送任何一則訊息
2. Bot 會回覆一組配對碼（例如 `84KXQ9XM`）
3. 回到 Ubuntu 終端機執行：

```bash
openclaw pairing approve telegram <配對碼>
```

配對成功後 bot 就會開始回應。

> 配對碼有效期限為一小時，若超時請重新傳訊息給 bot 取得新碼。

**驗證連線狀態：**

```bash
openclaw channels status
```

Telegram 欄位應顯示 `enabled, configured, running, mode:polling`。

---

## 步驟十三：安裝技能（Skills）

直接在 **Telegram** 裡跟 bot 說你想要的功能（例如「幫我設定 email skill」），它會引導你完成安裝。

也可以在終端機手動安裝：

```bash
openclaw skill install @openclaw/gmail
openclaw skill install @openclaw/google-calendar
openclaw skill install @openclaw/files
```

Google 服務安裝時會開啟瀏覽器進行一次 OAuth 授權登入，點「允許」即可。密碼**不會**被儲存，Google 會給 OpenClaw 一個安全憑證存在本地。

每次安裝完新技能後建議執行：

```bash
openclaw restart
```

---

## 進階設定：AI 助理人設（Persona）

OpenClaw 支援自訂 AI 助理的個性和行為模式，打造專屬於你的助理風格。

建議用以下 Prompt 透過 Claude 產生一份量身打造的人設：

> 「依照我的工作專業背景，以及個性需求，幫我寫一段給 OpenClaw 的 AI 助理人設。請先向我確認幾個問題（例如工作內容、溝通風格偏好、想要助理幫忙的任務類型等），並在正式撰寫前提出一段大綱讓我確認方向。」

Claude 會先問你幾輪問題了解需求，然後產出一份完整的 system prompt。

**套用人設的兩種方式：**
1. 直接在 Telegram 跟 bot 說「更新你的 system prompt」，然後貼上內容
2. 或直接貼到 OpenClaw 的設定檔中

你也可以把公司介紹、產品文件等丟到 Telegram 對話，跟 bot 說「請記住這份文件的內容」，讓它在回答問題時以這些資訊為基礎。

---

## 安全性注意事項

> 🔐 OpenClaw 對你的電腦有檔案讀寫和指令執行的權限，請認真執行以下措施。

- **使用專用電腦或帳號**——不要在存有個人重要資料的主力機器上直接安裝
- **建立獨立帳號**——為 OpenClaw 建立一個全新的 Gmail 和 Google Drive，只分享你想讓 AI 存取的資料夾和行事曆；Windows 上也建議建立獨立的使用者帳號
- **保護 Bot Token 和 API 金鑰**——絕對不要公開或提交到 Git repository
- **開啟 Telegram 兩步驟驗證**——防止帳號被盜後 bot 被他人控制
- **設定月消費上限**——在 Anthropic Console 設定，避免意外帳單
- **儀表板不要對外公開**——`localhost:18789` 僅供本機使用
- **定期備份**——`~/.openclaw` 資料夾內含所有憑證和記憶，定期備份避免資料遺失
- **限制存取來源**——用 `allowFrom` 設定只有你的 Telegram User ID 能控制 bot（只接受數字 ID，不接受 @username）

---

## 常用指令速查

| 指令 | 功能 |
|------|------|
| `openclaw start / stop / restart` | 啟動 / 停止 / 重啟服務 |
| `openclaw status` | 確認運作狀態 |
| `openclaw gateway status` | 查看 gateway 狀態 |
| `openclaw channels status` | 查看訊息管道狀態 |
| `openclaw logs --follow` | 查看即時 log（偵錯必備） |
| `openclaw doctor --fix` | 自動健康檢查 + 修復 |
| `openclaw update` | 更新到最新版 |
| `openclaw skills list` | 查看已安裝技能 |
| `openclaw config` | 查看/編輯設定 |
| `openclaw --install-daemon` | 設定開機自動啟動 |

---

## 常見問題

### Q1: WSL 安裝失敗，顯示「虛擬化未啟用」
**解決方案：**
1. 進入 BIOS 啟用 Intel VT-x 或 AMD-V
2. 或在 PowerShell 執行：
   ```powershell
   bcdedit /set hypervisorlaunchtype auto
   ```
3. 重新啟動電腦

### Q2: Ubuntu 無法啟動
**解決方案：**
```powershell
wsl --shutdown
wsl --unregister Ubuntu
wsl --install -d Ubuntu
```

### Q3: OpenClaw 指令找不到
**解決方案：**
```bash
source ~/.bashrc
# 或重新開啟 WSL 終端機
```

### Q4: visudo 編輯器不會用
**替代方案：**
```bash
sudo nano /etc/sudoers
# 加入：your_username ALL=(ALL) NOPASSWD: ALL
```

### Q5: Telegram bot 無回應（Token 有效但沒反應）
**解決方案：** 可能有 webhook 衝突，執行以下指令清除後重試：
```bash
openclaw gateway restart
```
若仍無效，檢查是否有舊版 process 殘留：
```bash
ps aux | grep openclaw
openclaw restart
```

### Q6: setMyCommands 網路請求失敗
**解決方案：** WSL2 DNS 沒修好，回到步驟四修復後再執行：
```bash
openclaw gateway restart
```

### Q7: pairing required 重複循環
**解決方案：** 舊版 process 殘留，執行：
```bash
ps aux | grep openclaw
openclaw restart
```

### Q8: allowFrom 設定不生效
**解決方案：** `allowFrom` 只接受數字 User ID，不接受 @username。執行：
```bash
openclaw doctor --fix
```

### Q9: 401 Unauthorized
**解決方案：** Token 複製時可能夾帶隱藏字元。回到 BotFather 重新產生 Token，複製時逐字確認無多餘空格。

---

**安裝時間：** 約 30-40 分鐘（視網路速度和遇到的問題而定）
