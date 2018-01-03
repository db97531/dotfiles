#!/bin/bash -e

echo "git user?"
read GIT_USER
echo "git emal?"
read GIT_EMAIL
export LANG=C

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
sudo apt-get update
sudo apt-get install -y neovim
sudo apt-get install -y python-dev python-pip python3-dev python3-pip
mkdir -p ~/.config/nvim

# neovimクリップボード連携用
sudo apt install -y xsel

# easy-motion日本語対応用
sudo apt install -y vim-migemo

# zshインストール
sudo apt install -y zsh
chsh -s /usr/bin/zsh

# Tmux
sudo apt install -y tmux

# Golang
mkdir ~/.go
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update -y
sudo apt-get install -y golang-go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"
echo " " >> ~/.bashrc
echo '# golang setting' >> ~/.bashrc
echo 'export GOPATH="$HOME/.go"' >> ~/.bashrc
echo 'export PATH="$PATH:$GOPATH/bin"' >> ~/.bashrc

# peco
go get github.com/peco/peco/cmd/peco

# Docker
# wget -qO- https://get.docker.com/ | sh
# sudo usermod -aG docker $USER

# Docker-compose
# sudo -i curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

