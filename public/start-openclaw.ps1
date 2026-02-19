# start-openclaw.ps1
# OpenClaw 環境一鍵啟動腳本
# Usage: irm https://taichis.github.io/ai-course/start-openclaw.ps1 | iex

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

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
multipass exec $VmName -- bash -c "echo 'export DISPLAY=${windowsIP}:0.0' >> ~/.bashrc"

# 5. 掛載資料夾（如果路徑存在）
if (Test-Path $MountPath) {
    Write-Host "📂 掛載資料夾 $MountPath ..." -ForegroundColor Yellow
    $mountInfo = multipass info $VmName | Select-String $MountPath
    if (-not $mountInfo) {
        multipass exec $VmName -- mkdir -p /home/ubuntu/project
        multipass mount "$MountPath" "${VmName}:/home/ubuntu/project"
        Write-Host "   ✅ 掛載完成" -ForegroundColor Green
    } else {
        Write-Host "   ℹ️  資料夾已掛載" -ForegroundColor Gray
    }
} else {
    Write-Host "   ⚠️  掛載路徑不存在: $MountPath（跳過掛載）" -ForegroundColor DarkYellow
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
