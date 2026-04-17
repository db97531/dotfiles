#!/bin/bash -e

# Docker Engine のインストール
# https://docs.docker.com/engine/install/ubuntu/

# 古いバージョンの削除
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg 2>/dev/null || true
done

# 必要なパッケージのインストール
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Docker の公式 GPG キーを追加
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Docker リポジトリを追加（OS のバージョンを自動検出）
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# Docker Engine + Docker Compose プラグインをインストール
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 現行ユーザを docker グループに追加（再ログイン後に有効）
sudo gpasswd -a $USER docker

echo "Docker setup finished!"
echo "Re-login or run 'newgrp docker' to use Docker without sudo."
