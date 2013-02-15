" 文字コード, 改行コード
set encoding=utf-8
set fileencodings=ucs_bom,utf8,ucs-2le,ucs-2
set fileformats=unix,dos,mac

filetype on
filetype indent on
"filetype plugin on
set listchars=tab:>-
set list
set ruler
set background=dark
set backspace=indent,eol,start
au BufNewFile,BufRead * set expandtab ts=2 sw=2 sts=2
au BufNewFile,BufRead *.cs set expandtab ts=4 sw=4 sts=4
au BufNewFile,BufRead *.c,*.cpp,*.h,*hpp set noexpandtab ts=4 sw=4 sts=4

" 検索関連
set ignorecase    " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase     " 検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan      " 検索時に最後まで行ったら最初に戻る
set noincsearch   " 検索文字列入力時に順次対象文字列にヒットさせない
" 装飾関連
set tabstop=4     " タブ幅を4文字にする
set shiftwidth=4  " cindentやautoindent時に挿入されるタブの幅（tabstop と揃えておくと良い）
set showmatch     " 括弧入力時の対応する括弧を表示
syntax on         " シンタックスハイライトを有効にする
set hlsearch      " 検索結果文字列のハイライトを有効にする
set laststatus=2  " ステータスラインを常に表示（編集中のファイル名が常に確認できるようになる）
set showcmd       " 入力中のコマンドをステータスに表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " ステータスラインに文字コードと改行文字を表示する
" その他
set hid           " 編集中の内容を保ったまま別の画面に切替えられるようにする(デフォルトだと一度保存しないと切り替えられない)


" 検索語が画面の真ん中に来るようにする"
"nmap n nzz 
"nmap N Nzz 
nmap * *zz 
nmap # #zz 
"nmap g* g*zz 
"nmap g# g#zz

nmap <C-g> :vimgrep ptn **/*.c \| cwin
nmap <C-N>  :bnext<CR>
nmap <C-P>  :bprevious<CR>
nmap <C-D>  :bdelete<CR>

" 表示行単位で行移動するようにする
nnoremap j gj
nnoremap k gk
