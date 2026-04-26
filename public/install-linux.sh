#!/bin/bash
# AI Agent 實作工作坊 - Linux 環境自動安裝腳本
# Author: 詹嘉隆 / AI Agent 實作工作坊
# Usage: curl -fsSL https://taichis.github.io/ai-course/install-linux.sh | bash
# 支援：Ubuntu 20.04+ / Debian 11+

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
echo "║    AI Agent 實作工作坊 - Linux 環境自動安裝        ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# 偵測發行版
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO="$ID"
    info "偵測到系統：$PRETTY_NAME"
else
    DISTRO="unknown"
    warn "無法偵測 Linux 發行版，將使用通用安裝方式"
fi

# 判斷套件管理器
if command -v apt &>/dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf &>/dev/null; then
    PKG_MANAGER="dnf"
elif command -v pacman &>/dev/null; then
    PKG_MANAGER="pacman"
else
    PKG_MANAGER="unknown"
fi

# --- 1. 更新套件列表 ---
info "更新套件列表..."
case "$PKG_MANAGER" in
    apt)    sudo apt update -q ;;
    dnf)    sudo dnf check-update -q || true ;;
    pacman) sudo pacman -Sy --noconfirm ;;
esac

# --- 2. 安裝基本工具 ---
info "安裝基本工具 (curl, git)..."
case "$PKG_MANAGER" in
    apt)    sudo apt install -y curl git ;;
    dnf)    sudo dnf install -y curl git ;;
    pacman) sudo pacman -S --noconfirm curl git ;;
esac
success "基本工具安裝完成"

# --- 3. 安裝 Node.js LTS (via NodeSource) ---
if command -v node &>/dev/null; then
    success "Node.js 已安裝 ($(node -v))"
else
    info "正在安裝 Node.js LTS..."
    case "$PKG_MANAGER" in
        apt)
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt install -y nodejs
            ;;
        dnf)
            curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
            sudo dnf install -y nodejs
            ;;
        *)
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
            export NVM_DIR="$HOME/.nvm"
            [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
            nvm install --lts
            ;;
    esac
    success "Node.js 安裝完成 ($(node -v))"
fi

# --- 4. 確認 Python ---
if command -v python3 &>/dev/null; then
    success "Python 已安裝 ($(python3 --version))"
else
    info "正在安裝 Python..."
    case "$PKG_MANAGER" in
        apt)    sudo apt install -y python3 python3-pip ;;
        dnf)    sudo dnf install -y python3 python3-pip ;;
        pacman) sudo pacman -S --noconfirm python python-pip ;;
    esac
    success "Python 安裝完成"
fi

# --- 5. 安裝 UV ---
if command -v uv &>/dev/null; then
    success "UV 已安裝"
else
    info "正在安裝 UV (Python 工具管理器)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    success "UV 安裝完成"
fi

# --- 6. 安裝或更新 Claude Code ---
if command -v claude &>/dev/null; then
    success "Claude Code 已安裝，正在更新至最新版本..."
    claude update && success "Claude Code 更新完成" || warn "claude update 失敗，請手動更新"
else
    info "正在安裝 Claude Code..."
    npm install -g @anthropic-ai/claude-code
    export PATH="$HOME/.local/bin:$PATH"
    success "Claude Code 安裝完成"
fi

# --- 7. 設定 cc 快捷指令 ---
info "正在設定 cc 快捷指令..."

SHELL_RC="$HOME/.bashrc"
CC_MARKER="permission-mode bypassPermissions"
CC_FUNCTION='
# === AI Agent 課程設定：cc 快捷指令 ===
function cc() {
    claude --permission-mode bypassPermissions "$@"
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

install_vscode_linux() {
    if command -v snap &>/dev/null; then
        sudo snap install --classic code && success "VS Code 安裝完成 (via snap)"
    elif [ "$PKG_MANAGER" = "apt" ]; then
        curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
        echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        sudo apt update -q && sudo apt install -y code
        success "VS Code 安裝完成"
    else
        warn "請手動安裝 VS Code：https://code.visualstudio.com/docs/setup/linux"
    fi
}

install_obsidian_linux() {
    local installed=false
    if command -v snap &>/dev/null; then
        sudo snap install obsidian --classic && installed=true && success "Obsidian 安裝完成 (via snap)"
    fi
    if [ "$installed" = false ] && [ "$PKG_MANAGER" = "apt" ]; then
        local deb_url
        deb_url=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest \
            | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4 | head -1)
        if [ -n "$deb_url" ]; then
            local tmp_deb
            tmp_deb=$(mktemp /tmp/obsidian-XXXXXX.deb)
            curl -fsSL "$deb_url" -o "$tmp_deb"
            sudo dpkg -i "$tmp_deb" || sudo apt -f install -y
            rm -f "$tmp_deb"
            installed=true
            success "Obsidian 安裝完成 (via .deb)"
        fi
    fi
    if [ "$installed" = false ]; then
        warn "無法自動安裝 Obsidian，請前往 https://obsidian.md/download 手動下載"
    fi
}

# VS Code
if command -v code &>/dev/null; then
    success "VS Code 已安裝，跳過。"
else
    printf "${YELLOW}是否現在安裝 VS Code？[Y = 安裝 / 直接按 Enter 跳過]：${NC} "
    read vs_choice </dev/tty
    if [[ "$vs_choice" =~ ^[Yy]$ ]]; then
        install_vscode_linux
    else
        info "已跳過 VS Code。日後可至 https://code.visualstudio.com/ 下載安裝。"
    fi
fi

# Obsidian
if command -v obsidian &>/dev/null || (command -v snap &>/dev/null && snap list obsidian &>/dev/null 2>&1); then
    success "Obsidian 已安裝，跳過。"
else
    printf "${YELLOW}是否現在安裝 Obsidian？[Y = 安裝 / 直接按 Enter 跳過]：${NC} "
    read ob_choice </dev/tty
    if [[ "$ob_choice" =~ ^[Yy]$ ]]; then
        install_obsidian_linux
    else
        info "已跳過 Obsidian。日後可至 https://obsidian.md/download 下載安裝。"
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

print_version "Git"         "$(git --version 2>/dev/null)"
print_version "Node.js"     "$(node -v 2>/dev/null)"
print_version "Python"      "$(python3 --version 2>/dev/null)"
print_version "VS Code"     "$(code --version 2>/dev/null | head -1)"
print_version "UV"          "$(uv --version 2>/dev/null)"
print_version "Claude Code" "$(claude --version 2>/dev/null)"

# Obsidian 版本偵測
if command -v obsidian &>/dev/null; then
    OBSIDIAN_VER="$(obsidian --version 2>/dev/null || echo '已安裝')"
elif command -v snap &>/dev/null && snap list obsidian &>/dev/null 2>&1; then
    OBSIDIAN_VER="$(snap list obsidian 2>/dev/null | awk 'NR==2{print $2}')"
else
    OBSIDIAN_VER="（請確認安裝狀態）"
fi
print_version "Obsidian" "$OBSIDIAN_VER"

echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║               ✅ 環境建置完成！                   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
info "後續步驟："
info "1. 執行 source ~/.bashrc 或重新開啟終端機"
info "2. 輸入 'claude' 進入互動模式"
info "3. 輸入 '/login' 登入 Google 帳號"
info "4. 開始享受 AI 輔助開發的樂趣！"
