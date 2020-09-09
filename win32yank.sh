#!/bin/bash

WIN32_YANK=~/.local/bin/win32yank.exe

function get_win32yank {
    curl -L -o /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
    unzip /tmp/win32yank.zip -d /tmp/win32yank
    mv /tmp/win32yank/win32yank.exe "$WIN32_YANK"
    rm -rf /tmp/win32yank*
    chmod +x "$WIN32_YANK"
}

[ ! -f "$WIN32_YANK" ] && get_win32yank
