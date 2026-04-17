
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.1


# python必須ライブラリ
sudo apt update; sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

# (1) plugin のインストール
#asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# (2) plugin を介したソフトウェアのインストール
#asdf install nodejs latest
# (3) ローカルのバージョンの指定
#asdf local nodejs latest
# (4) `.tool-versions` に記載されているソフトウェアのインストール
#asdf install

