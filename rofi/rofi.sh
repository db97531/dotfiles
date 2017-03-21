#!/bin/bash

options=(
    -font               'RictyDiminished-Regular 14'
    -terminal           'urxvt'
    -color-enabled      'true'
    -color-window       '#111111,#111111,#268bd2'
    -color-normal       '#111111,#ffffff,#111111,#268bd2,#ffffff'
    -color-active       '#111111,#268bd2,#111111,#268bd2,#000022'
    -color-urgent       '#111111,#f3843d,#111111,#268bd2,#ffc39c'   
    -separator-style    'none'
    -opacity            '80'

    -kb-cancel          'Escape,Control+bracketleft'
    -kb-mode-next       'Control+Tab,Control+i'

    -hide-scrollbar

)

rofi "${@}" "${options[@]}"
