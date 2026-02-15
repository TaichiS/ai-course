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

# --- 5. 安裝 VS Code ---
if command -v code &>/dev/null; then
    success "VS Code 已安裝"
else
    info "正在安裝 VS Code..."
    if command -v snap &>/dev/null; then
        sudo snap install --classic code
        success "VS Code 安裝完成 (via snap)"
    elif [ "$PKG_MANAGER" = "apt" ]; then
        curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
        echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        sudo apt update -q && sudo apt install -y code
        success "VS Code 安裝完成"
    else
        warn "請手動安裝 VS Code：https://code.visualstudio.com/docs/setup/linux"
    fi
fi

# --- 6. 安裝 UV ---
if command -v uv &>/dev/null; then
    success "UV 已安裝"
else
    info "正在安裝 UV (Python 工具管理器)..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.local/bin:$PATH"
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    success "UV 安裝完成"
fi

# --- 7. 安裝 Claude Code ---
if command -v claude &>/dev/null; then
    success "Claude Code 已安裝"
else
    info "正在安裝 Claude Code..."
    npm install -g @anthropic-ai/claude-code
    export PATH="$HOME/.local/bin:$PATH"
    success "Claude Code 安裝完成"
fi

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
