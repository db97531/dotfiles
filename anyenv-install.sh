#!/bin/bash -e

# phpenv PHPビルド依存プログラムのインストール
sudo apt install -y libxml2-dev
sudo apt install -y libcurl-dev
sudo apt install -y libcurl4-gnutls-dev
sudo apt install -y libjpeg-dev
sudo apt install -y libtidy-dev
sudo apt install -y libxslt-dev
sudo apt install -y autoconf

pyenv install 3.6.4
pyenv global 3.6.4
pyenv rehash

pyenv install 2.7.14

nodenv install 8.11.2
nodenv global 8.11.2
nodenv rehash

plenv install 5.26.1
plenv global 5.26.1
plenv rehash

rbenv install 2.5.0
rbenv global 2.5.0
rbenv rehash

phpenv install 7.2.6
phpenv global 7.2.6
phpenv rehash
