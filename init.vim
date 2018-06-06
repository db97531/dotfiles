if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"==========================
"エンコーディング設定
"==========================
set encoding=utf-8
scriptencoding utf-8

"==========================
"キーマップ系設定
"==========================

"LeaderをSpaceに変更
let mapleader = "\<Space>"

" 端末のCtrl+Spaceのキーマップの上書き対策
imap <Nul> <C-Space>

" カーソルを表示行で移動する。
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk

" Q(exモード)を無効化
nnoremap Q <Nop>

" Esc２回でハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR>

" ウィンドウ分割
nnoremap <C-w>/ :vs<CR>
nnoremap <C-w>- :sp<CR>

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" Pythonインデント設定
inoremap # X<C-H>#

" ターミナル設定
if has('nvim')
	" 水平分割でターミナル起動
    nnoremap @t :sp<CR>:terminal<CR>i
	" Ctrl + q でターミナルを終了
	tnoremap <C-q> <C-\><C-n>:q<CR>
	" ESCでターミナルモードからノーマルモードへ
	" tnoremap <ESC> <C-\><C-n>
	tnoremap <Leader>q <C-\><C-n>
endif

"#################################################################################################
" dein settings {{{
" dein自体の自動インストール
" let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:cache_home = expand('~/.config/nvim/')
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = s:cache_home . '/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}
"#################################################################################################

" 曖昧幅文字を全角に固定
set ambiwidth=double

" クリップボード連携
" set clipboard+=unnamedplus
set clipboard=unnamedplus

" ステータス行を常に表示
set laststatus=2

" 検索結果ハイライト
set hlsearch

"新しいバッファを右に開く
set splitright

"スマートケース
set smartcase

"大文字小文字を無視
set ignorecase

"行番号の表示
set number

"保存しなくても別ファイルを開けるように
set hidden

"新しく開く代わりにすでに開いているバッファを開く
set switchbuf=useopen

"スワップファイfji jeijル作らない
set noswapfile

"バックアップ取らない
set nobackup

"カーソルが何行目の何列目に置かれているかを表示する
set ruler

"ウインドウのタイトルバーにファイルのパス情報等を表示する
set title

"構文毎に文字色を変化させる
syntax on

"タブ入力を複数の空白入力に置き換える
set expandtab

"自動インデントを有効に
set smartindent

"行末・行頭から次の行へ移動可能に
set whichwrap=h,l,<,>,[,],b,s

"タブ文字の表示幅
set tabstop=4

"Vimが挿入するインデントの幅
set shiftwidth=4

"行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab

"不可視文字を表示する
set list

"タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<

"補完時に大文字小文字を区別しない
set infercase

"上下の表示を確保
set scrolloff=8

"ウィンドウサイズの自動調整を無効化
set noequalalways

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" 補完の際にプレビューウィンドウを表示しない
set completeopt-=preview

"==============================================================
"
" プラグイン固有の設定
"
"==============================================================

" quickrunのバッファを<Leader>qで閉じる
nnoremap <Leader>q :<C-u>bw! \[quickrun\ output\]<CR>

" NERDTree隠しファイルも初期表示する
" dein.tomlでのhook_addで設定できなかったためここで設定する
let NERDTreeShowHidden = 1

" スニペットファイル定義
let g:neosnippet#snippets_directory='~/.config/nvim/snippets/'

" Enable filetype plugins
filetype plugin on
