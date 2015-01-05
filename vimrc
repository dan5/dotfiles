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
"au BufNewFile,BufRead *.cs set expandtab ts=4 sw=4 sts=4
au BufNewFile,BufRead *.cs,*.c,*.cpp,*.h,*hpp set noexpandtab ts=4 sw=4 sts=4
au BufNewFile,BufRead *.boo set syntax=boo

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



nmap ,v :call SWikiOpenTag()<CR>


" [[https://gist.github.com/fum1h1ro/6901177]]
" 簡易Wiki的なもの
" テキスト中にある、[[hoge]]のようにタグで括られた文字列をファイル名としてジャンプします
" nmap ,v :call SWikiOpenTag()<CR>
" とでもしておくと便利かも
 
let g:SWikiTagBegin = '[['
let g:SWikiTagEnd = ']]'
let g:SWikiDirectory = '~/swiki'
let g:SWikiExtention = '.txt'
" hoge日本語[[test]][[]]
function! SWikiOpenTag()
    call s:open_tag()
endfunction
 
function! s:open_tag()
    let tagname = s:find_tag(getline('.'), col('.')-1)
    if tagname != ''
        let tagname = iconv(tagname, &encoding, 'UTF-8')
        if s:is_http(tagname)
            call system('open ' . tagname)
        else
            let tagfilename = s:make_filename(tagname)
            call s:dig_dir()
            echo s:make_path(tagname)
            execute 'e ' . s:make_path(tagname)
        endif
    endif
endfunction
 
function! s:find_tag(text, startpos)
    let rightpos = s:search_tag_end(a:text, a:startpos, g:SWikiTagEnd) - 1
    let leftpos = s:search_tag_begin(a:text, rightpos, g:SWikiTagBegin) + strlen(g:SWikiTagBegin)
    if leftpos >= 0 && rightpos >= 0
        return a:text[leftpos : rightpos]
    endif
    return ''
endfunction
 
function! s:search_tag_begin(text, startpos, tagstr)
    let len = strlen(a:tagstr)-1
    let startpos = min([a:startpos+len, strlen(a:text)-1])
    let left = a:text[0 : startpos]
    let leftpos = match(left, '.*\zs' . a:tagstr)
    return leftpos
endfunction
 
function! s:search_tag_end(text, startpos, tagstr)
    let len = strlen(a:tagstr)-1
    let startpos = max([a:startpos-len, 0])
    let right = a:text[startpos : -1]
    let rightpos = match(right, a:tagstr)
    return rightpos >= 0 ? rightpos + startpos : rightpos
endfunction
 
function! s:encode_filename(filename)
    " todo 文字のエンコード
    let encname = iconv(a:filename, &encoding, 'UTF-8')
    return encname
endfunction
 
function! s:is_http(name)
    return match(a:name, '^https\?://') >= 0
endfunction
 
function! s:make_filename(name)
    return s:encode_filename(a:name) . g:SWikiExtention
endfunction
 
function! s:make_path(name)
    return g:SWikiDirectory . '/' . s:make_filename(a:name)
endfunction
 
function! s:dig_dir()
    let dir = iconv(expand(g:SWikiDirectory), &encoding, 'UTF-8')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endfunction


"---------------------------
" Start Neobundle Settings.
"---------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"
" NERDTreeを設定
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'leafo/moonscript-vim'
NeoBundle 'grep.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------
