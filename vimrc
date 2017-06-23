set nocompatible
set smartindent
set autoindent
iab setheader #!/usr/bin/env python<CR># encoding=utf8<CR># made by zodman
set modeline
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
set background=dark
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set nu

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'othree/html5.vim'
Plugin 'posva/vim-vue'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
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
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'three/javascript-libraries-syntax.vim'
Plugin 'bash-support.vim'

Plugin 'chase/vim-ansible-yaml'
call vundle#end()            " required
filetype plugin indent on    " required

"folding settings
set foldmethod=marker   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set cursorline
syntax on
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS " Ignore compiled Python files
set foldenable " Turn on folding.
set t_Co=256
set modeline
set mouse=a
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


"colo solarized
colo PaperColor
"colo badwolf

let NERDTreeIgnore=['\.swp$','\.pyc$','\.pyo$', '\.swo$']
set pastetoggle=<F3>
nnoremap <silent> <F2> :NERDTreeToggle<CR>

nnoremap ,s :w!<CR>
nnoremap ,d   :Bdelete<CR>

nnoremap <silent> ,q :bp<CR>
nnoremap <silent> ,w :bn<CR>
nnoremap _hd :set ft=htmldjango<CR>
nnoremap _dh :set ft=htmldjango<CR>
nnoremap _dt :set ft=htmldjango<CR>
nnoremap _pd :set ft=python.django<CR>
nnoremap _hb :set ft=handlebars<CR>

au BufNewFile,BufRead *.vue setf vue.html.javascript.css
au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" ,  "is not recognized!", "discarding unexpected"]

" https://github.com/webpack/webpack/issues/781#issuecomment-95523711
set backupcopy=yes
