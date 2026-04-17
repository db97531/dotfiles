#!/bin/bash -e

sudo apt install autoconf -y
sudo apt install pkg-config -y

git clone https://github.com/universal-ctags/ctags.git

cd ctags

./autogen.sh

./configure  # defaults to /usr/local

make

sudo make install # may require extra privileges depending on where to install
