set noswapfile
set nobackup
set nocompatible
set smartindent
set autoindent
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
Plugin 'jlanzarotta/bufexplorer'
Plugin 'django.vim'
Plugin 'sjl/badwolf'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'moll/vim-bbye'
Plugin 'gregsexton/matchtag'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'chase/vim-ansible-yaml'
Plugin 'mileszs/ack.vim'
"Plugin 'editorconfig/editorconfig-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
"Plugin 'bash-support.vim'
"Plugin 'jonathanfilip/vim-lucius'
Plugin 'stanangeloff/php.vim'
Plugin 'cespare/vim-toml'
"Plugin 'wakatime/vim-wakatime'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'dracula/vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'hdima/python-syntax'
Plugin 'chriskempson/base16-vim'
Plugin 'bennyyip/vim-yapf'
Plugin 'digitaltoad/vim-pug'
Plugin 'reedes/vim-lexical'
Plugin 'mgedmin/coverage-highlight.vim'
Plugin 'raimon49/requirements.txt.vim'

call vundle#end()            " required
filetype plugin indent on    " required

"folding settings
"set foldmethod=indent   "fold based on indent
"set foldnestmax=5       "deepest fold is 3 levels
set cursorline
syntax on
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS,htmlcov " Ignore compiled Python files
set foldenable " Turn on folding.
set modeline
set mouse=
"set t_ut=
"set t_Co=256

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

let python_highlight_all=1
syntax on

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*



"colo solarized
"colo PaperColor
"colo badwolf

let NERDTreeIgnore=['\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__','htmlcov','node_modules']
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

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

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
\ }

au BufNewFile,BufRead *.vue setf vue.html.javascript.css
au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2
autocmd BufNewFile,BufReadPost *.jade set filetype=pug

iab setheader #!/usr/bin/env python<CR># encoding=utf8<CR># made by zodman
autocmd BufNewFile,BufRead *.jade set filetype=pug

let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" ,  "is not recognized!", "discarding unexpected"]

" https://github.com/webpack/webpack/issues/781#issuecomment-95523711
set backupcopy=yes

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$|bower_components|node_modules|www|platform',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.swp$|\.swo',
    \ }

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

let g:indentLine_enabled = 1


if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag %s -l --nocolor -f -g ""'
else
  "ctrl+p ignore files in .gitignore
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif


nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

augroup lexical
  autocmd!
  autocmd FileType markdown,mkd call lexical#init()
  autocmd FileType textile call lexical#init()
  autocmd FileType text call lexical#init({ 'spell': 0 })
augroup END
let g:lexical#spelllang = ['es','es_mx',]
let g:syntastic_typescript_tsc_args = "-t ES5 -m commonjs --experimentalDecorators --emitDecoratorMetadata --sourceMap true --moduleResolution node"

