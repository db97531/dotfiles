# WSLのGUI対応
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then

    if [ $SHLVL = 1 ] ; then
        # 半角/全角キー点滅問題対応
        # xset -r 49  > /dev/null 2>&1
        # fcitx-autostart
        (fcitx-autostart > /dev/null 2>&1 &)
    fi

    # デフォルトの初期ディレクトリがWindowsのディレクトリになるのでホームへ強制移動
    cd ~
fi

