#!/bin/bash -e

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
