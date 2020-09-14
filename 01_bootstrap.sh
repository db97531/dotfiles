#!/bin/bash -e

export LANG=C

# nanoアンインストール
sudo apt remove -y nano

# vimprocのmakeに必要
sudo apt-get install -y build-essential

# neovimインストール
sudo apt-get install -y software-properties-common
sudo apt-get install -y neovim
sudo apt-get install -y python3-dev python3-pip
mkdir -p ~/.config/nvim

# neovimクリップボード連携用
sudo apt install -y xsel

# easy-motion日本語対応用
sudo apt install -y vim-migemo

# zshインストール
sudo apt install -y zsh
# chsh -s /usr/bin/zsh

# Tmux
sudo apt install -y tmux

# ctags
sudo apt install -y ctags

# Golang
mkdir -p ~/.go
sudo apt install -y software-properties-common
sudo apt-get install -y golang-go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

# Windows用コンパイラ
sudo apt install -y mingw-w64
# peco
go get github.com/peco/peco/cmd/peco

# ghq
go get github.com/motemen/ghq

# pet
wget https://github.com/knqyf263/pet/releases/download/v0.3.0/pet_0.3.0_linux_amd64.deb
sudo dpkg -i pet_0.3.0_linux_amd64.deb
mkdir -p ~/.config/pet
rm ./pet_0.3.0_linux_amd64.deb

# anyenv
if [ ! -d ~/.anyenv ]; then
    git clone https://github.com/riywo/anyenv ~/.anyenv
fi

# pyenv
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev

# pyenv-virtualenv
if [ ! -d ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ];
    then git clone https://github.com/yyuu/pyenv-virtualenv ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
fi


# jq
sudo apt install -y jq

# sqlite3
sudo apt install -y sqlite3 libsqlite3-dev

# DB browser for sql
sudo apt install -y sqlitebrowser


# vim clang-format用
sudo apt install -y clang-format

# .fontsディレクトリ作成
mkdir ~/.fonts

# Google Chromeのインストール
sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt update -y
sudo apt install -y google-chrome-stable


# ctop
sudo wget https://github.com/bcicen/ctop/releases/download/v0.7.3/ctop-0.7.3-linux-amd64 -O /usr/local/bin/ctop
sudo chmod +x /usr/local/bin/ctop


# starship
curl -fsSL https://starship.rs/install.sh | bash -- -y

# WSL用 win32yank セットアップ
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    source ./win32yank.sh
fi

# シェル変更
chsh -s $(which zsh)

bash ./symlink.sh

echo "setup finished!"
echo "next step is .."
echo "0:(option) uninstall Firefox"
echo "1:setup Qsync"
echo "2:execute ./ssh_qsync.sh"
echo "3:reboot system and do after-setup-scripts!"
