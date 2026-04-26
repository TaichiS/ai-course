#!/bin/bash
# AI Agent 實作工作坊 - macOS 環境自動安裝腳本
# Author: 詹嘉隆 / AI Agent 實作工作坊
# Usage: curl -fsSL https://taichis.github.io/ai-course/install-mac.sh | bash

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${CYAN}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║    AI Agent 實作工作坊 - macOS 環境自動安裝        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# 偵測 CPU 架構
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    info "偵測到 Apple Silicon (M 系列晶片)"
    BREW_PREFIX="/opt/homebrew"
else
    info "偵測到 Intel 處理器"
    BREW_PREFIX="/usr/local"
fi

# --- 1. 安裝 Homebrew ---
if command -v brew &>/dev/null; then
    success "Homebrew 已安裝"
else
    info "正在安裝 Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$($BREW_PREFIX/bin/brew shellenv)"
    # 永久加入 PATH
    SHELL_PROFILE="$HOME/.zprofile"
    if [[ "$SHELL" == *"bash"* ]]; then SHELL_PROFILE="$HOME/.bash_profile"; fi
    echo "eval \"\$($BREW_PREFIX/bin/brew shellenv)\"" >> "$SHELL_PROFILE"
    success "Homebrew 安裝完成"
fi

# --- 2. 安裝 Git ---
if command -v git &>/dev/null; then
    success "Git 已安裝"
else
    info "正在安裝 Git..."
    brew install git
    success "Git 安裝完成"
fi

# --- 3. 安裝 Node.js ---
if command -v node &>/dev/null; then
    success "Node.js 已安裝 ($(node -v))"
else
    info "正在安裝 Node.js LTS..."
    brew install node
    success "Node.js 安裝完成"
fi

# --- 4. 安裝 Python ---
if command -v python3 &>/dev/null; then
    success "Python 已安裝 ($(python3 --version))"
else
    info "正在安裝 Python..."
    brew install python
    success "Python 安裝完成"
fi

# --- 5. 安裝 UV ---
if command -v uv &>/dev/null; then
    success "UV 已安裝"
else
    info "正在安裝 UV (Python 工具管理器)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    success "UV 安裝完成"
fi

# --- 6. 安裝或更新 Claude Code ---
if command -v claude &>/dev/null; then
    success "Claude Code 已安裝，正在更新至最新版本..."
    # 偵測安裝來源：Homebrew 優先
    if brew list --cask claude-code &>/dev/null 2>&1; then
        brew upgrade --cask claude-code && success "Claude Code 更新完成 (via Homebrew cask)" || warn "Homebrew 更新失敗，改用 claude update..."  && claude update
    elif brew list claude-code &>/dev/null 2>&1; then
        brew upgrade claude-code && success "Claude Code 更新完成 (via Homebrew formula)" || warn "Homebrew 更新失敗，改用 claude update..." && claude update
    else
        claude update && success "Claude Code 更新完成" || warn "claude update 失敗，請手動更新"
    fi
else
    info "正在安裝 Claude Code..."
    if brew install --cask claude-code 2>/dev/null; then
        success "Claude Code 安裝完成 (via Homebrew)"
    else
        npm install -g @anthropic-ai/claude-code
        success "Claude Code 安裝完成 (via npm)"
    fi
fi

# --- 7. 設定 cc 快捷指令 ---
info "正在設定 cc 快捷指令..."

# 決定 shell profile 路徑
if [[ "$SHELL" == *"zsh"* ]]; then
    SHELL_RC="$HOME/.zshrc"
else
    SHELL_RC="$HOME/.bash_profile"
fi

CC_MARKER="CLAUDE_CODE_NO_FLICKER"
CC_FUNCTION='
# === AI Agent 課程設定：cc 快捷指令 ===
function cc() {
    CLAUDE_CODE_NO_FLICKER=1 claude --permission-mode bypassPermissions "$@"
}
# =========================================='

if grep -q "$CC_MARKER" "$SHELL_RC" 2>/dev/null; then
    success "cc 快捷指令已存在，跳過（保留現有設定）"
else
    echo "$CC_FUNCTION" >> "$SHELL_RC"
    success "已新增 cc 快捷指令至 $SHELL_RC"
fi

# --- 可選安裝：VS Code 與 Obsidian ---
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║       ⏳ 可選安裝（安裝時間較長，可跳過）         ║"
echo "║  VS Code 與 Obsidian 安裝時間較長。               ║"
echo "║  課程核心功能不依賴這兩項，有空再安裝即可。        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# VS Code（從 /dev/tty 讀取，相容 curl pipe 執行方式）
if command -v code &>/dev/null; then
    success "VS Code 已安裝，跳過。"
else
    printf "${YELLOW}是否現在安裝 VS Code？[Y = 安裝 / 直接按 Enter 跳過]：${NC} "
    read vs_choice </dev/tty
    if [[ "$vs_choice" =~ ^[Yy]$ ]]; then
        info "正在安裝 VS Code..."
        brew install --cask visual-studio-code
        success "VS Code 安裝完成"
    else
        info "已跳過 VS Code。日後可至 https://code.visualstudio.com/ 下載安裝。"
    fi
fi

# Obsidian
if brew list --cask obsidian &>/dev/null 2>&1; then
    success "Obsidian 已安裝，跳過。"
else
    printf "${YELLOW}是否現在安裝 Obsidian？[Y = 安裝 / 直接按 Enter 跳過]：${NC} "
    read ob_choice </dev/tty
    if [[ "$ob_choice" =~ ^[Yy]$ ]]; then
        info "正在安裝 Obsidian..."
        brew install --cask obsidian
        success "Obsidian 安裝完成"
    else
        info "已跳過 Obsidian。日後可至 https://obsidian.md/ 下載安裝。"
    fi
fi

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║            📦 已安裝軟體版本清單                  ║"
echo "╠══════════════════════════════════════════════════╣"

print_version() {
    local name="$1"
    local version="$2"
    printf "║  %-18s %s\n" "$name" "${version:-（無法取得版本）}"
}

print_version "Homebrew"    "$(brew --version 2>/dev/null | head -1)"
print_version "Git"         "$(git --version 2>/dev/null)"
print_version "Node.js"     "$(node -v 2>/dev/null)"
print_version "Python"      "$(python3 --version 2>/dev/null)"
print_version "VS Code"     "$(code --version 2>/dev/null | head -1)"
print_version "UV"          "$(uv --version 2>/dev/null)"
print_version "Claude Code" "$(claude --version 2>/dev/null)"
print_version "Obsidian"    "$(brew info --cask obsidian 2>/dev/null | grep -m1 'obsidian:' | awk '{print $2}' || echo '已安裝')"

echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║               ✅ 環境建置完成！                   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
info "後續步驟："
info "1. 重新開啟終端機（或執行 source ~/.zshrc）"
info "2. 輸入 'claude' 進入互動模式"
info "3. 輸入 '/login' 登入 Google 帳號"
info "4. 開始享受 AI 輔助開發的樂趣！"
