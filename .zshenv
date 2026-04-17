export GOPATH="$HOME/.go"
export PATH="$HOME/.local/bin:$GOPATH/bin:/usr/local/go/bin:$PATH"

# WSLのGUI対応（WSL2のみ）
if grep -qEi "(Microsoft|WSL)" /proc/version 2>/dev/null; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export DefaultIMModule=fcitx
fi
