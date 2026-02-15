<#
.SYNOPSIS
    AI Agent 實作工作坊 - Windows 環境自動安裝腳本
.DESCRIPTION
    此腳本自動檢查並安裝課程所需的所有工具：
    1. Git (含 Git Bash)
    2. Node.js (LTS)
    3. Python 3
    4. VS Code
    5. UV (Python 工具管理器)
    6. Claude Code (含自動 PATH 修復)
.NOTES
    需搭配 install.ps1 一起使用
    Author: 詹嘉隆 / AI Agent 實作工作坊
    Version: 2026.2
#>

# --- 錯誤處理設定：讓錯誤不會閃退 ---
$ErrorActionPreference = "Continue"
$ProgressPreference = "SilentlyContinue"  # 加速下載，避免進度條問題

# --- 輔助函式：顯示訊息 ---
function Show-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Show-Success {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor Green
}

function Show-Warning {
    param([string]$Message)
    Write-Host "[WARN] $Message" -ForegroundColor Yellow
}

function Show-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

# --- 安全執行 Winget 安裝 ---
function Install-WithWinget {
    param(
        [string]$PackageId,
        [string]$PackageName
    )

    try {
        Show-Info "正在透過 Winget 安裝 $PackageName..."
        $result = winget install --id $PackageId -e --source winget --accept-source-agreements --accept-package-agreements 2>&1

        if ($LASTEXITCODE -eq 0) {
            Show-Success "$PackageName 安裝完成。"
            return $true
        } else {
            Show-Error "$PackageName 安裝失敗 (Exit Code: $LASTEXITCODE)"
            Show-Warning "錯誤訊息: $result"
            return $false
        }
    } catch {
        Show-Error "$PackageName 安裝時發生例外錯誤: $($_.Exception.Message)"
        return $false
    }
}

# --- 安全執行遠端腳本 ---
function Invoke-RemoteScript {
    param(
        [string]$Url,
        [string]$ScriptName
    )

    try {
        Show-Info "正在下載並執行 $ScriptName..."
        $response = Invoke-WebRequest -Uri $Url -UseBasicParsing -ErrorAction Stop

        # 處理回傳內容可能是 Byte[] 或 String 的情況
        if ($response.Content -is [byte[]]) {
            $scriptText = [System.Text.Encoding]::UTF8.GetString($response.Content)
        } else {
            $scriptText = $response.Content
        }

        Invoke-Expression $scriptText
        Show-Success "$ScriptName 執行完成。"
        return $true
    } catch {
        Show-Error "$ScriptName 下載或執行失敗: $($_.Exception.Message)"
        return $false
    }
}

# --- 檢查管理員權限 ---
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Show-Warning "請以「以系統管理員身分執行」此腳本，以確保軟體能順利安裝！"
    Write-Host ""
    Write-Host "按任意鍵結束..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# --- 設定 PowerShell 執行原則 (允許執行本地腳本) ---
$currentPolicy = Get-ExecutionPolicy -Scope CurrentUser
if ($currentPolicy -eq "Restricted" -or $currentPolicy -eq "Undefined") {
    Show-Info "正在設定 PowerShell 執行原則為 RemoteSigned..."
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Show-Success "PowerShell 執行原則已設定，現在可以執行本地腳本。"
    } catch {
        Show-Warning "無法設定執行原則: $($_.Exception.Message)"
        Show-Info "您可以手動執行: Set-ExecutionPolicy RemoteSigned -Scope CurrentUser"
    }
} else {
    Show-Success "PowerShell 執行原則已正確設定 ($currentPolicy)。"
}

Show-Info "=== 開始安裝 AI Agent 實作工作坊 所需環境 ==="

# --- 偵測 CPU 架構 ---
$cpuArch = $env:PROCESSOR_ARCHITECTURE
$cpuIdentifier = $env:PROCESSOR_IDENTIFIER

switch ($cpuArch) {
    "AMD64" {
        $archDisplay = "x64 (64-bit Intel/AMD)"
        $archColor = "Green"
    }
    "ARM64" {
        $archDisplay = "ARM64 (Apple M 系列晶片 / Qualcomm Snapdragon)"
        $archColor = "Magenta"
    }
    "x86" {
        $archDisplay = "x86 (32-bit)"
        $archColor = "Yellow"
    }
    default {
        $archDisplay = "未知架構: $cpuArch"
        $archColor = "Red"
    }
}

Write-Host ""
Write-Host "╔══════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║           📊 系統 CPU 架構偵測結果                ║" -ForegroundColor Cyan
Write-Host "╠══════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║  架構類型: " -ForegroundColor Cyan -NoNewline
Write-Host "$archDisplay".PadRight(38) -ForegroundColor $archColor -NoNewline
Write-Host "║" -ForegroundColor Cyan
Write-Host "║  處理器  : " -ForegroundColor Cyan -NoNewline
$truncatedCpu = if ($cpuIdentifier.Length -gt 38) { $cpuIdentifier.Substring(0, 35) + "..." } else { $cpuIdentifier }
Write-Host "$truncatedCpu".PadRight(38) -ForegroundColor White -NoNewline
Write-Host "║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# 儲存架構資訊供後續使用
$global:SystemArchitecture = $cpuArch
Show-Info "Winget 會根據您的 $archDisplay 架構自動選擇正確版本"
Write-Host ""

Show-Info "正在檢查必要工具..."

# --- 1. 檢查與安裝 Git (Git Bash) ---
if (Get-Command git -ErrorAction SilentlyContinue) {
    Show-Success "Git 已安裝。"
} else {
    $null = Install-WithWinget -PackageId "Git.Git" -PackageName "Git"
}

# --- 2. 檢查與安裝 Node.js (LTS) ---
if (Get-Command node -ErrorAction SilentlyContinue) {
    Show-Success "Node.js 已安裝。"
} else {
    $null = Install-WithWinget -PackageId "OpenJS.NodeJS.LTS" -PackageName "Node.js LTS"
}

# --- 3. 檢查與安裝 Python ---
if (Get-Command python -ErrorAction SilentlyContinue) {
    Show-Success "Python 已安裝。"
} else {
    $null = Install-WithWinget -PackageId "Python.Python.3.12" -PackageName "Python 3.12"
}

# --- 4. 檢查與安裝 VS Code ---
if (Get-Command code -ErrorAction SilentlyContinue) {
    Show-Success "VS Code 已安裝。"
} else {
    $null = Install-WithWinget -PackageId "Microsoft.VisualStudioCode" -PackageName "VS Code"
}

# --- 刷新環境變數 (讓剛安裝的工具在當前 Session 可見) ---
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# --- 5. 檢查與安裝 UV (Python 工具) ---
if (Get-Command uv -ErrorAction SilentlyContinue) {
    Show-Success "UV 已安裝。"
} else {
    $null = Invoke-RemoteScript -Url "https://astral.sh/uv/install.ps1" -ScriptName "UV (Python 工具管理器)"
}

# --- 6. 安裝 Claude Code ---
# 先檢查是否已安裝
if (Get-Command claude -ErrorAction SilentlyContinue) {
    Show-Success "Claude Code 已安裝。"
} else {
    Show-Info "正在安裝 Claude Code..."

    # 刷新 PATH 以確保 npm 可用
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

    # 方法 1: 使用 npm 全域安裝 (最可靠)
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        try {
            Show-Info "使用 npm 安裝 Claude Code..."
            $npmResult = npm install -g @anthropic-ai/claude-code 2>&1
            if ($LASTEXITCODE -eq 0) {
                Show-Success "Claude Code 透過 npm 安裝完成。"
            } else {
                Show-Warning "npm 安裝失敗，嘗試官方腳本..."
                $null = Invoke-RemoteScript -Url "https://claude.ai/install.ps1" -ScriptName "Claude Code (官方腳本)"
            }
        } catch {
            Show-Warning "npm 安裝出錯: $($_.Exception.Message)"
            $null = Invoke-RemoteScript -Url "https://claude.ai/install.ps1" -ScriptName "Claude Code (官方腳本)"
        }
    } else {
        Show-Warning "npm 不可用，使用官方腳本安裝..."
        $null = Invoke-RemoteScript -Url "https://claude.ai/install.ps1" -ScriptName "Claude Code (官方腳本)"
    }
}

# --- 7. 自動修復 Claude Code 的 PATH ---
# Claude Code 可能安裝在多個位置
$npmGlobalPath = npm config get prefix 2>$null
$possiblePaths = @(
    "$env:USERPROFILE\.local\bin",
    "$env:USERPROFILE\.claude\bin",
    "$env:APPDATA\Claude\bin",
    "$env:LOCALAPPDATA\Claude\bin",
    "$env:LOCALAPPDATA\Programs\claude",
    "$env:APPDATA\npm",
    "$npmGlobalPath"
)

$claudeFound = $false
$claudePath = $null

# 搜尋 claude.exe 的位置
foreach ($path in $possiblePaths) {
    $claudeExe = Join-Path $path "claude.exe"
    if (Test-Path $claudeExe) {
        $claudePath = $path
        $claudeFound = $true
        Show-Success "找到 Claude Code: $claudeExe"
        break
    }
}

# 也嘗試用 where.exe 搜尋
if (-not $claudeFound) {
    try {
        $whereResult = where.exe claude 2>$null
        if ($whereResult) {
            $claudeDir = Split-Path $whereResult -Parent
            $claudePath = $claudeDir
            $claudeFound = $true
            Show-Success "找到 Claude Code: $whereResult"
        }
    } catch {}
}

if ($claudeFound -and $claudePath) {
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

    # 檢查路徑是否已存在於 PATH 中
    if ($currentPath -notlike "*$claudePath*") {
        Show-Info "正在將 Claude Code 路徑加入環境變數..."

        # 將新路徑加到最前面（優先順序更高）
        $newPath = $claudePath + ";" + $currentPath
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")

        # 更新當前 Session
        $env:Path = $claudePath + ";" + $env:Path
        Show-Success "環境變數 PATH 已修正！"
    } else {
        Show-Success "Claude Code 路徑設定正確。"
    }
} else {
    Show-Warning "找不到 claude.exe，Claude Code 可能安裝失敗。"
    Show-Info "請嘗試手動安裝: powershell -c `"irm https://claude.ai/install.ps1 | iex`""

    # 列出搜尋過的路徑供除錯
    Show-Info "已搜尋以下路徑："
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            $files = Get-ChildItem $path -ErrorAction SilentlyContinue | Select-Object -First 5
            Show-Info "  [存在] $path"
            foreach ($f in $files) {
                Show-Info "         - $($f.Name)"
            }
        } else {
            Show-Info "  [不存在] $path"
        }
    }
}

# 最終驗證
Show-Info ""
Show-Info "=== 驗證 Claude Code 安裝 ==="
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
if (Get-Command claude -ErrorAction SilentlyContinue) {
    $claudeVersion = claude --version 2>$null
    Show-Success "Claude Code 可用！版本: $claudeVersion"
} else {
    Show-Warning "Claude Code 指令仍無法使用，請重新開啟 PowerShell 後再試。"
}

Show-Info "=== 環境建置完成！ ==="
Show-Info "請執行以下步驟以完成設定："
Show-Info "1. 關閉此視窗，重新開啟一個新的 PowerShell 或 Git Bash。"
Show-Info "2. 輸入 'claude' 並按 Enter，完成 Google 帳號登入。"
Show-Info "3. 開始享受 AI 輔助開發的樂趣！"

Pause
