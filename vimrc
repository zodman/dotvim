set nocompatible

filetype plugin on
filetype plugin indent on
set smartindent
set modeline
iab setheader #!/usr/bin/env python<CR># encoding=utf8<CR># vim: tabstop=8 expandtab shiftwidth=4 softtabstop=4<CR># made by zodman
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
set background=dark
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'posva/vim-vue'
Plugin 'scrooloose/nerdtree'
Plugin 'othree/html5.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'scrooloose/syntastic'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'tpope/vim-surround'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'django.vim'
Plugin 'sjl/badwolf'
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
Plugin 'moll/vim-bbye'
Plugin 'gregsexton/matchtag'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'

call vundle#end()            " required
filetype plugin indent on    " required

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set cursorline
syntax on
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS " Ignore compiled Python files
set foldenable " Turn on folding.


"colo PaperColor
colo badwolf

let NERDTreeIgnore = ['\.pyc$']
nnoremap ,s :update!<CR>
nnoremap ,d   :Bdelete<CR>

nnoremap _hd :set ft=htmldjango<CR>
nnoremap _dh :set ft=htmldjango<CR>
nnoremap _pd :set ft=python.django<CR>
nnoremap _hb :set ft=handlebars<CR>
nnoremap <silent> ,q :bp<CR>
nnoremap <silent> ,w :bn<CR>
