#!/bin/bash -e

echo "git user?"
read GIT_USER
echo "git emal?"
read GIT_EMAIL
export LANG=C

# nanoアンインストール
sudo apt remove -y nano

# Git
git config --global user.name $GIT_USER
git config --global user.email $GIT_EMAIL
git config --global alias.s status
git config --global alias.co checkout
git config --global alias.l log
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.lga "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global push.default simple

# vimprocのmakeに必要
sudo apt-get install -y build-essential

# neovimインストール
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt-get update -y
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
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
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update -y
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
go get github.com/knqyf263/pet
mkdir -p ~/.config/pet

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

# Docker
sudo apt-get install -y apt-transport-https \
                       ca-certificates
curl -fsSL https://yum.dockerproject.org/gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.dockerproject.org/repo/ ubuntu-xenial main"
sudo apt-get update -y
sudo apt-get install -y docker-engine

# Docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 現行ユーザをdockerグループに所属させる
sudo gpasswd -a $USER docker

# jq
sudo apt install -y jq

# sqlite3
sudo apt install -y sqlite3 libsqlite3-dev

# DB browser for sql
sudo apt install -y sqlitebrowser


# vim clang-format用
sudo apt install -y clang-format

# RictyDiminishedのインストール
mkdir ~/.fonts
git clone https://github.com/edihbrandon/RictyDiminished.git
mv RictyDiminished/*.ttf ~/.fonts/
rm -rf RictyDiminished/

chsh -s $(which zsh)

bash ./setup.sh

echo "setup finished!"
echo "next step is .."
echo "0:(option) uninstall Firefox"
echo "1:setup Qsync"
echo "2:execute ./ssh_qsync.sh"
echo "3:reboot system and do after-setup-scripts!"
