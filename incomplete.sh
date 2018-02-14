# sqlite3
sudo apt install -y sqlite3 libsqlite3-dev

# DB browser for sql
sudo apt install -y sqlitebrowser

# Dropbox
wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -P ~/ -
mkdir -p ~/.local/bin
wget -O ~/.local/bin/dropbox.py "https://www.dropbox.com/download?dl=packages/dropbox.py"
chmod +x ~/.local/bin/dropbox.py
ln -s -T ~/.local/bin/dropbox.py ~/.local/bin/dropbox
