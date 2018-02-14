#!/bin/bash

# RictyDiminishedのインストール
mkdir ~/.fonts
git clone https://github.com/edihbrandon/RictyDiminished.git
mv RictyDiminished/*.ttf ~/.fonts/
rm -rf RictyDiminished/
