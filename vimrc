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
" CORE
Plugin 'scrooloose/nerdtree'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-syntastic/syntastic'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'gregsexton/matchtag'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'moll/vim-bbye' " Bdelete
" OTHER LANGUAGUAGES
Plugin 'mtscout6/syntastic-local-eslint.vim'

Plugin 'othree/html5.vim'
Plugin 'posva/vim-vue'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'pangloss/vim-javascript'
Plugin 'django.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'stanangeloff/php.vim'
Plugin 'cespare/vim-toml'
"THEMES
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'sjl/badwolf'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
" " Pythons
Plugin 'vim-scripts/indentpython.vim'
Plugin 'hdima/python-syntax'
Plugin 'raimon49/requirements.txt.vim'
"Plugin 'digitaltoad/vim-pug'
" WRITING
Plugin 'reedes/vim-lexical'
"Plugin 'raimondi/delimitmate'

call vundle#end()            " required
filetype plugin indent on    " required

"folding settings
"set foldmethod=indent   "fold based on indent
"set foldnestmax=5       "deepest fold is 3 levels
set cursorline
syntax on
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS,htmlcov,*report*,coverage" Ignore compiled Python files
set foldenable " Turn on folding.
set modeline
set mouse=

set t_Co=256
colorscheme gruvbox
set background=dark
syntax on


if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

let python_highlight_all=1
syntax on
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline#extensions#tabline#enabled = 1



let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn



"colo solarized
"colo PaperColor
"colo badwolf

let NERDTreeIgnore=['\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__','htmlcov','node_modules', '*report*']
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



