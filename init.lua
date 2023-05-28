require "bootstrap"
require "plugins"
require "nvim_cmp_config"

vim.opt.termguicolors = true -- 24ビットRGBカラーを有効にする
vim.opt.number = true -- 行番号を表示
vim.opt.wrap = false -- 折返しの設定
vim.opt.cursorline = true -- カーソル行を強調表示
vim.opt.scrolloff = 8 -- 上下の表示を確保(スクロール時に見やすくするために設定)
vim.opt.sidescrolloff = 8 -- 左右の表示を確保(スクロール時に見やすくするために設定)
vim.opt.winblend = 10 -- floating windows の透明度を設定(数値を%で指定)
vim.opt.pumblend = 5 -- ポップアップウィンドウの透明度を設定(数値を%で指定)
vim.opt.wildoptions = "pum" -- Vim でコマンドラインモードでも補完ポップアップ
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.swapfile = false -- スワップファイルを作らない
vim.opt.smartcase = true --検索パターンに大文字を含むときだけ大文字・小文字を区別して検索
vim.opt.cmdheight = 2
vim.opt.ambiwidth = "double" -- 曖昧幅文字を全角に固定
vim.opt.laststatus = 2 -- lightline用の設定
vim.opt.hlsearch = true -- 検索結果をハイライト
vim.opt.ignorecase = true -- 大文字小文字を無視
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a" -- マウスを有効化
vim.opt.splitright = true -- 新しいバッファを右に開く
vim.opt.hidden = true -- 保存しなくても別ファイルを開けるように
vim.opt.switchbuf = "useopen" -- 新しく開く代わりにすでに開いているバッファを開く
vim.opt.swapfile = false -- スワップファイルを作らない
vim.opt.backup = false -- バックアップとらない
vim.opt.ruler = true -- カーソルが何行目の何列目におかれているかを表示する
vim.opt.title = true -- ウィンドウのタイトルバーにファイルのパス情報等を表示する
vim.opt.syntax = "on" -- 構文ごとに文字色を変化させる
vim.opt.expandtab = true -- タブ入力を複数の空白入力に置き換える
vim.opt.smartindent = true -- 自動インデントを有効に
vim.opt.whichwrap = "h,l,<,>,[,],b,s" -- 行末・行頭から次の行へ移動可能に
vim.opt.tabstop = 4 -- タブ文字の表示幅
vim.opt.shiftwidth = 4 -- Vimが挿入するインデントの幅
vim.opt.smarttab = true -- 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
vim.opt.list = true -- 不可視文字を表示する
vim.opt.infercase = true -- 補完時に大文字小文字を区別しない
vim.opt.scrolloff = 8 -- 上下の表示を確保
vim.opt.equalalways = false -- ウィンドウサイズの自動調整を無効化
vim.opt.pumheight = 10 -- 変換候補で一度に表示される数



-- タブと行の続きを可視化する
-- #set listchars=tab:>\ ,extends:<

-- #補完の際にプレビューウィンドウを表示しない
-- #set completeopt-=preview


-- # augroupをリセット
--vim.api.nvim_create_augroup('MyAutoCmd', { clear = true })


-- #Leaderをスペースに変更
vim.g.mapleader = ' '

-- Q(exモード)を無効化
vim.api.nvim_set_keymap("n", 'Q', '<Nop>', {noremap = true})

-- ESC2回でハイライト消去
vim.api.nvim_set_keymap("n", '<ESC><ESC>', ':nohlsearch<CR>', {noremap = true})

-- " ウィンドウ分割
vim.api.nvim_set_keymap("n", '<C-w>/', ':vs<CR>', {noremap = true})
vim.api.nvim_set_keymap("n", '<C-w>-', ':sp<CR>', {noremap = true})

-- " 端末のCtrl+Spaceのキーマップの上書き対策
-- " imap <Nul> <C-Space>
vim.api.nvim_set_keymap("n", '<Nul>', '<C-Space>', {noremap = true})

-- vim.cmd 'colorscheme badwolf'
vim.cmd 'colorscheme iceberg'

-- preservim/vim-indent-guidesの自動起動
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_guide_size = 1
-- plugins.luqを保存すると自動でPackerCompileを実行
--vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
--vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
--vim.cmd[[
--  augroup Packer_aug
--  autocmd!
--  autocmd BufWritePost plugins.lua PackerCompile
--  autocmd BufWritePost plugins.lua PackerClean
--  autocmd BufWritePost plugins.lua PackerInstall
--  augroup END
--]]
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "plugins.lua" },
  command = "PackerCompile",
})

