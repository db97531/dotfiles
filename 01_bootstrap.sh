#!/bin/bash -e

export LANG=C

# 環境判定
is_wsl() { grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; }

# コマンドが存在するか確認
has_cmd() { command -v "$1" &>/dev/null; }

# nanoアンインストール
if has_cmd nano; then
    sudo apt remove -y nano
fi

# vimprocのmakeに必要
sudo apt-get install -y build-essential

sudo apt install -y curl

# neovimインストール
# tarball を ~/.local 配下に展開し PATH を通す方式（sudo 不要、バージョン管理が容易）
# https://github.com/neovim/neovim/blob/master/INSTALL.md
if [ ! -f ~/.local/opt/nvim/bin/nvim ]; then
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    tar -xzf nvim-linux-x86_64.tar.gz -C /tmp/
    mkdir -p ~/.local/opt
    rm -rf ~/.local/opt/nvim
    mv /tmp/nvim-linux-x86_64 ~/.local/opt/nvim
    rm nvim-linux-x86_64.tar.gz
fi
mkdir -p ~/.local/bin
ln -sf ~/.local/opt/nvim/bin/nvim ~/.local/bin/nvim
mkdir -p ~/.config/nvim/

# neovimクリップボード連携用
# WSL2: win32yank を使うため xsel は不要
# VPS : xsel を使用
if ! is_wsl; then
    sudo apt install -y xsel
fi

# easy-motion日本語対応用
sudo apt install -y vim-migemo

# zshインストール
sudo apt install -y zsh

# Tmux
sudo apt install -y tmux

# ctags
# エラーになったので削除、別スクリプトに
#sudo apt install -y ctags

# Golang 最新バージョンをインストール
# https://zenn.dev/tamagram/articles/fd744d10e2e680
if ! has_cmd go; then
    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo apt update
    sudo apt install golang-go
fi

mkdir -p ~/.go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# peco
sudo apt install -y peco

# Windows用クロスコンパイラ（WSL2のみ）
if is_wsl; then
    sudo apt install -y mingw-w64
fi

# ghq
if ! has_cmd ghq; then
    go install github.com/x-motemen/ghq@latest
fi

# pet
if ! has_cmd pet; then
    wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb
    sudo dpkg -i pet_0.3.0_linux_amd64.deb
    rm ./pet_0.3.0_linux_amd64.deb
fi
mkdir -p ~/.config/pet

# jq
sudo apt install -y jq

# sqlite3
sudo apt install -y sqlite3 libsqlite3-dev

# DB browser for sqlite（WSL2のみ：VPSはヘッドレスのため不要）
if is_wsl; then
    sudo apt install -y sqlitebrowser
fi

# vim clang-format用
sudo apt install -y clang-format

# .fontsディレクトリ作成
mkdir -p ~/.fonts

# Google Chrome（WSL2のみ：VPSはヘッドレスのため不要）
if is_wsl && ! has_cmd google-chrome-stable; then
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/keyrings/google-chrome.asc > /dev/null
    sudo chmod a+r /etc/apt/keyrings/google-chrome.asc
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.asc] http://dl.google.com/linux/chrome/deb/ stable main" | \
        sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
    sudo apt update -y
    sudo apt install -y google-chrome-stable
fi

# ctop
if [ ! -f /usr/local/bin/ctop ]; then
    sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.3/ctop-0.7.3-linux-amd64 -O /usr/local/bin/ctop
    sudo chmod +x /usr/local/bin/ctop
fi

# starship
if ! has_cmd starship; then
    curl -sS https://starship.rs/install.sh | sh
fi

# WSL用 win32yank セットアップ（クリップボード連携）
if is_wsl; then
    source ./win32yank.sh
fi

# ripgrep
sudo apt install -y ripgrep

# fd
sudo apt install -y fd-find

# cmake（telescope-fzf-native.nvimのインストールに必要）
sudo apt install -y cmake

# シェル変更
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

bash ./symlink.sh

echo "setup finished!"
if is_wsl; then
    echo "next step is .."
    echo "0:(option) uninstall Firefox"
    echo "1:setup Qsync"
    echo "2:execute ./ssh_qsync.sh"
    echo "3:reboot system and do after-setup-scripts!"
fi
