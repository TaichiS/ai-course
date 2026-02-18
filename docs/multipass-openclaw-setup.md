# Multipass AI Agent (OpenClaw) 環境建置指南

本指南將帶領你從零開始，在 Windows 10 上透過 Multipass 建立一個具備 GUI 顯示能力（執行 Chrome）與 systemd 支援的 Ubuntu 環境，供 OpenClaw AI Agent 使用。

---

## 1. 安裝 Multipass (宿主機)

首先，請先在 Windows 10 上安裝 Multipass：

* **下載連結**：[https://canonical.com/multipass/install](https://canonical.com/multipass/install)
* 安裝完成後，請重啟電腦以確保環境變數生效。

---

## 2. 建立並配置 openclaw 虛擬機

開啟 PowerShell，執行以下指令建立一個高效能的環境（建議 4 核 CPU / 8GB RAM）：

```powershell
# 1. 建立虛擬機
multipass launch --name openclaw --cpus 4 --memory 8G --disk 40G

# 2. (選配) 若日後需要修改資源，請先 stop 再 set
# multipass stop openclaw
# multipass set local.openclaw.cpus=4
# multipass set local.openclaw.memory=8G
# multipass start openclaw
```

---

## 3. 配置 GUI 顯示環境 (Windows 宿主機端)

為了讓 Ubuntu 裡的 Chrome 畫面能顯示在 Windows 上，我們需要 X11 Server：

1. 下載並安裝 [VcXsrv (XLaunch)](https://sourceforge.net/projects/vcxsrv/)。
2. 啟動 **XLaunch**，選擇 `Multiple windows`。
3. 在設定頁面務必勾選 **`Disable access control`**。
4. 完成啟動（Windows 右下角小圖示會出現一個「X」）。

---

## 4. 進入 Ubuntu 並安裝 OpenClaw 與 Chrome

執行 `multipass shell openclaw` 進入虛擬機，接著在 Linux 終端機執行：

### A. 更新系統與安裝 Node.js

```bash
sudo apt update && sudo apt upgrade -y
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs git
```

### B. 安裝 Chrome 瀏覽器

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
```

### C. 安裝 OpenClaw

```bash
# 使用官方安裝腳本
curl -fsSL https://openclaw.ai/install.sh | bash

# 設定 PATH
export PATH="$HOME/.npm-global/bin:$PATH"
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 驗證安裝
openclaw --version
```

---

## 5. 掛載宿主機檔案（Windows ↔ Ubuntu 檔案共享）

在 Multipass 中，存取宿主機（Windows）檔案最快且最直覺的方式是使用 **mount (掛載)** 功能。這能讓宿主機的資料夾直接出現在 Ubuntu 虛擬機的路徑中，實現雙向同步。

### 5.1 使用 mount 指令（最推薦）

你可以在 PowerShell 中將 Windows 的某個資料夾掛載到 openclaw 內。

**指令格式**：
```powershell
multipass mount "<宿主機路徑>" openclaw:<虛擬機路徑>
```

**實戰範例**：
假設你想將 Windows 的 `C:\ai_project` 資料夾掛載到 Ubuntu 裡的 `/home/ubuntu/project`：

```powershell
# 1. 在虛擬機內先建立目標目錄
multipass exec openclaw -- mkdir -p /home/ubuntu/project

# 2. 執行掛載（注意：路徑含空白需加引號）
multipass mount "C:\ai_project" openclaw:/home/ubuntu/project

# 3. 驗證結果
multipass info openclaw
# 你會在 Mounts 欄位看到對應關係
```

**掛載後的優勢**：
- **雙向同步**：在 Windows 修改檔案，Ubuntu 內會立即更新；反之亦然
- **VS Code 開發**：在 Windows 用 VS Code 寫程式，讓 Ubuntu 裡的 OpenClaw 執行
- **資料持久化**：即使刪除虛擬機，檔案仍保留在 Windows

**卸載指令**：
```powershell
multipass umount openclaw
```

### 5.2 使用 transfer 指令（單次搬移）

如果你不想建立持續的連動，只想「丟一個檔案進去」或「拿一個結果出來」：

```powershell
# 從 Windows 傳入 Ubuntu
multipass transfer C:\config.json openclaw:/home/ubuntu/

# 從 Ubuntu 傳回 Windows
multipass transfer openclaw:/home/ubuntu/log.txt C:\logs\
```

### 5.3 進階：透過 VS Code 遠端開發（推薦）

對於 OpenClaw 開發者，推薦直接從 Windows 的 VS Code 連進虛擬機：

1. 在 Windows VS Code 安裝 **"Remote - SSH"** 擴充功能
2. 透過 `multipass list` 取得 openclaw 的 IP
3. 在 VS Code 按 `F1` → `Remote-SSH: Connect to Host` → `ubuntu@<你的IP>`
4. 輸入密碼（預設為 `ubuntu`）

這樣你就能直接在 Windows 視窗裡編寫虛擬機內的檔案，且擁有完整的 Intellisense 支援。

---

## 6. 設定顯示連結 (Display)

在 Ubuntu 內，讓程式知道要把畫面傳送到 Windows 的哪裡：

```bash
echo "export DISPLAY=<Host_IP>:0.0" >> ~/.bashrc
source ~/.bashrc
```

**取得 Windows IP 的方法**：在 PowerShell 執行 `ipconfig`，找到你的區域網路 IP（例如 `192.168.1.10`）。

---

## 7. 一鍵啟動腳本（自動化設定）

為了簡化每次重啟電腦後的環境設定，我們提供一個 PowerShell 腳本，會自動：
1. 偵測 Windows IP
2. 設定 Ubuntu 的 DISPLAY 環境變數
3. 掛載指定的 Windows 資料夾

### 7.1 建立啟動腳本

在 Windows 建立檔案 `start-openclaw.ps1`：

```powershell
# start-openclaw.ps1
# OpenClaw 環境一鍵啟動腳本

param(
    [string]$MountPath = "C:\ai_project",
    [string]$VmName = "openclaw"
)

Write-Host "🚀 啟動 OpenClaw 環境..." -ForegroundColor Cyan

# 1. 檢查虛擬機狀態
Write-Host "📋 檢查虛擬機狀態..." -ForegroundColor Yellow
$vmInfo = multipass info $VmName 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Error "❌ 虛擬機 $VmName 不存在，請先執行 multipass launch"
    exit 1
}

# 2. 啟動虛擬機（如果未運行）
$vmState = multipass list | Select-String $VmName | ForEach-Object { ($_ -split "\s+")[1] }
if ($vmState -ne "Running") {
    Write-Host "▶️  啟動虛擬機..." -ForegroundColor Yellow
    multipass start $VmName
}

# 3. 取得 Windows IP（用於 X11 顯示）
Write-Host "🌐 偵測 Windows IP..." -ForegroundColor Yellow
$windowsIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
    $_.InterfaceAlias -notlike "*Loopback*" -and 
    $_.IPAddress -notlike "169.254.*" -and
    $_.IPAddress -like "192.168.*"
} | Select-Object -First 1).IPAddress

if (-not $windowsIP) {
    $windowsIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { 
        $_.InterfaceAlias -notlike "*Loopback*" -and 
        $_.IPAddress -notlike "169.254.*"
    } | Select-Object -First 1).IPAddress
}

Write-Host "   Windows IP: $windowsIP" -ForegroundColor Green

# 4. 設定 Ubuntu 的 DISPLAY
Write-Host "🖥️  設定 DISPLAY 環境變數..." -ForegroundColor Yellow
multipass exec $VmName -- bash -c "echo 'export DISPLAY=$windowsIP`:0.0' >> ~/.bashrc"
multipass exec $VmName -- bash -c "export DISPLAY=$windowsIP`:0.0"

# 5. 掛載資料夾（如果路徑存在）
if (Test-Path $MountPath) {
    Write-Host "📂 掛載資料夾 $MountPath ..." -ForegroundColor Yellow
    
    # 檢查是否已掛載
    $mountInfo = multipass info $VmName | Select-String $MountPath
    if (-not $mountInfo) {
        multipass exec $VmName -- mkdir -p /home/ubuntu/project
        multipass mount "$MountPath" "$VmName`: /home/ubuntu/project"
        Write-Host "   ✅ 掛載完成" -ForegroundColor Green
    } else {
        Write-Host "   ℹ️  資料夾已掛載" -ForegroundColor Gray
    }
} else {
    Write-Host "   ⚠️  掛載路徑不存在: $MountPath" -ForegroundColor Red
}

# 6. 顯示狀態摘要
Write-Host ""
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "✅ OpenClaw 環境已就緒！" -ForegroundColor Green
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
Write-Host "虛擬機: $VmName"
Write-Host "Windows IP: $windowsIP"
Write-Host "掛載路徑: $MountPath → /home/ubuntu/project"
Write-Host ""
Write-Host "常用指令："
Write-Host "  進入虛擬機: multipass shell $VmName"
Write-Host "  啟動 Gateway: openclaw gateway start"
Write-Host "  查看狀態: multipass info $VmName"
Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
```

### 7.2 使用腳本

```powershell
# 基本使用（掛載預設路徑 C:\ai_project）
.\start-openclaw.ps1

# 指定其他路徑
.\start-openclaw.ps1 -MountPath "D:\my-workspace"

# 指定其他虛擬機名稱
.\start-openclaw.ps1 -VmName "my-agent"
```

### 7.3 建立桌面捷徑（選配）

1. 在桌面建立新的捷徑
2. 目標輸入：`powershell.exe -ExecutionPolicy Bypass -File "C:\path\to\start-openclaw.ps1"`
3. 命名為「啟動 OpenClaw」
4. （選配）變更圖示

---

## 8. 使用與管理

### 啟動 OpenClaw Gateway

```bash
openclaw gateway start
```

### 使用 systemd 管理服務（選配）

如果你希望 OpenClaw 在背景常駐，可以建立服務檔：

```bash
sudo nano /etc/systemd/system/openclaw.service
```

內容範例：

```ini
[Unit]
Description=OpenClaw AI Agent Service
After=network.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/.npm-global/bin/openclaw gateway start
Restart=always

[Install]
WantedBy=multi-user.target
```

啟動服務：

```bash
sudo systemctl enable --now openclaw
```

---

## 常用 Multipass 指令快速參考

| 指令 | 說明 |
|-----|------|
| `multipass info openclaw` | 查看虛擬機狀態 |
| `multipass shell openclaw` | 進入虛擬機終端機 |
| `multipass stop openclaw` | 停止虛擬機 |
| `multipass start openclaw` | 啟動虛擬機 |
| `multipass delete openclaw` | 刪除虛擬機（接著執行 `multipass purge` 徹底清空） |
| `multipass mount <src> openclaw:<dst>` | 掛載資料夾 |
| `multipass umount openclaw` | 卸載所有掛載 |

---

## 故障排除

### 問題：openclaw 指令找不到

```bash
# 確認 PATH 設定
export PATH="$HOME/.npm-global/bin:$PATH"
source ~/.bashrc

# 檢查是否安裝成功
ls -la ~/.npm-global/bin/openclaw
```

### 問題：Chrome 無法顯示畫面

1. 確認 VcXsrv 已啟動且勾選「Disable access control」
2. 確認 Windows 防火牆允許 X11 連線
3. 確認 `DISPLAY` 環境變數設定正確

### 問題：掛載後檔案權限錯誤

```bash
# 在 Ubuntu 內修正權限
sudo chown -R ubuntu:ubuntu /home/ubuntu/project
```

### 問題：安裝腳本失敗

嘗試手動安裝：

```bash
npm config set prefix '~/.npm-global'
npm install -g openclaw
```

---

*本指南更新日期：2026-02-18*
