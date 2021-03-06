" ================================================
" Basic section
" ================================================
" no vi-keyboard
set nocompatible

" history lins
set history=100

" encoding
set fenc=utf-8
set fencs=utf-8,gb18030,gbk,gb2312,cp936,euc-jp

" share clipboard
set clipboard+=unnamed

" no visual bell
set novisualbell
" no bell(in awesome)
" set vb t_vb=

" slim gui
set guioptions=ai
set mouse=a

" keywords
set iskeyword+=_,$,@,#,-

" auto read
set autoread

" auto dir
set autochdir

" line number
set number

" syntax colo
syntax on

" set indent
set autoindent
set smartindent

" ================================================ 
" View section
" ================================================ 
" colo schema
if has("gui_running")
  colo desertEx
  set guifont=YaHei\ Consolas\ Hybrid\ for\ Powerline\ 10
  set linespace=0
  set cursorline
elseif $TERM == 'xterm' || $TERM == "screen-256color" || $TERM == "rxvt-unicode-256color"
  set t_Co=256
  colo desertEx_term
else
  colo elflord
endif

" status bar
set laststatus=2
"set ruler
"set rulerformat=%60(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" cli height
set cmdheight=2


" ================================================ 
" Edit section
" ================================================ 
" set cond comment
set formatoptions+=r
" linewrap for latex
au FileType plaintex setlocal formatoptions+=Mm textwidth=80
let g:tex_fast=""

" set filetype
au VimEnter,BufNew,BufRead, *.{md,mkd} set ft=mkd
au VimEnter,BufNew,BufRead, *.jade set ft=jade
au VimEnter,BufNew,BufRead, *.ejs set ft=html
au BufNew,BufRead *.{asm,inc} set ft=nasm

" set tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"au FileType html,jade setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
au FileType make setlocal tabstop=4 shiftwidth=4 noexpandtab

" show bracket match
set showmatch
set matchtime=2

" config backspace act
set backspace=eol,start,indent

" search hint
set incsearch
set ignorecase
set smartcase

" auto close [] () {}
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i

" use space to folden
set foldmethod=syntax
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<cr>
set foldopen-=search
set foldopen-=undo

" ================================================ 
" Moving section
" ================================================ 
" remap 0
map 0 ^

" move as break line
map j gj
map k gk

" move line text
nnoremap <M-k>  mz:m-2<cr>`z==
nnoremap <M-j>  mz:m+<cr>`z==
xnoremap <M-k>  :m'<-2<cr>gv=gv
xnoremap <M-j>  :m'>+<cr>gv=gv

" smart move windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" scroll down half page
func! Scrolld()
  exec "normal ".(winheight(winnr())/2)."\<C-e>"
endfunc
map <C-d> :call Scrolld()<cr>

" tab page switch
func! TabPos_ActivateBuffer(num)
    let s:count = a:num 
  exe "tabfirst"
  exe "tabnext" s:count  
endfunc

func! TabPos_Initialize()
    for i in range(1, 9) 
        exe "map <M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "map <M-0> :call TabPos_ActivateBuffer(10)<CR>"
endfunc

" toggle tree&buffer view
func! LSidebarToggle()
    let b = bufnr("%")
    "exec "NERDTreeToggle | BuffergatorToggle"
    exec "NERDTreeToggle"
    exec bufwinnr(b) . "wincmd w"
endfunc

" ================================================ 
" Initialize utilities
" ================================================ 
autocmd VimEnter * call TabPos_Initialize()
