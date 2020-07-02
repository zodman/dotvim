set noswapfile
set nobackup
set nocompatible
set smartindent
set autoindent
set modeline
let g:netrw_list_hide= '.*\.swp$,.*\.pyc,coverage/'
set background=dark
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set nu
set cursorline
syntax on

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
"Plugin 'mtscout6/syntastic-local-eslint.vim'
Plugin 'sheerun/vim-polyglot' " hightlight for files
Plugin 'jlanzarotta/bufexplorer'
Plugin 'gregsexton/matchtag'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'moll/vim-bbye' " Bdelete
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"" OTHER LANGUAGUAGES
Plugin 'othree/html5.vim'
Plugin 'posva/vim-vue'
Plugin 'django.vim'
" Snippets
Plugin 'isRuslan/vim-es6'
Plugin 'joaohkfaria/vim-jest-snippets'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'stanangeloff/php.vim'
Plugin 'cespare/vim-toml'
Plugin 'retorillo/istanbul.vim'
""THEMES
Plugin 'vim-airline/vim-airline'
Plugin 'sainnhe/sonokai'
Plugin 'tomasr/molokai'
""Plugin 'vim-airline/vim-airline-themes'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'sjl/badwolf'
Plugin 'morhetz/gruvbox'
Plugin 'altercation/vim-colors-solarized'
Plugin 'dracula/vim', { 'name': 'dracula' }
"" " Pythons
Plugin 'vim-scripts/indentpython.vim'
Plugin 'hdima/python-syntax'
Plugin 'mgedmin/coverage-highlight.vim'
Plugin 'raimon49/requirements.txt.vim'
Plugin 'mindriot101/vim-yapf'
""Plugin 'digitaltoad/vim-pug'
" WRITING
Plugin 'dpelle/vim-LanguageTool'
Plugin 'takac/vim-hardtime'
call vundle#end()            " required
filetype plugin indent on    " required
filetype plugin on
" automplete
set omnifunc=syntaxcomplete#Complete

set conceallevel=0


"folding settings
set foldmethod=manual   "fold based on indent
"set foldnestmax=3       "deepest fold is 3 levels
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS,htmlcov,*report*,coverage/*
set foldenable " Turn on folding.
set modeline
set mouse=
set t_Co=256

" let g:solarized_termcolors=256

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

let python_highlight_all=1


set laststatus=2
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1


" SYNTASTIC
let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
" disable syntax by default
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" let g:syntastic_mode_map = {'mode':'passive'}
"let g:syntastic_loc_list_height = 5
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
"\let g:syntastic_javascript_eslint_exec = 'eslint'
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty <", "unescaped &" ,  "is not recognized!", "discarding unexpected"]
let g:syntastic_typescript_tsc_args = "-t ES5 -m commonjs --experimentalDecorators --emitDecoratorMetadata --sourceMap true --moduleResolution node"
highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn





" colorscheme gruvbox
"colo solarized
" colo PaperColor
"colo badwolf

let NERDTreeIgnore=['\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__', 'htmlcov','node_modules', '*report*', 'coverage', '^tags$']
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1

nnoremap <silent> <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
noremap <F4> :!ctags -R<CR>
nnoremap <F9> :SyntasticCheck<CR> :SyntasticToggleMode<CR> :w<CR>

nnoremap ,s :w!<CR>
nnoremap ,d   :Bdelete<CR>

nnoremap <silent> ,q :bp<CR>
nnoremap <silent> ,w :bn<CR>

nnoremap <silent> ,1 :tabprev<CR>
nnoremap <silent> ,2 :tabnext<CR>


nnoremap _hd :set ft=htmldjango<CR>
nnoremap _dh :set ft=htmldjango<CR>
nnoremap _dt :set ft=htmldjango<CR>
nnoremap _pd :set ft=python.django<CR>
nnoremap _hb :set ft=handlebars<CR>
" ejecute last command
map <leader>l :<Up><CR>
map <leader>f :!prettier-eslint_d --write %:p  <CR>
nnoremap gp :silent %!prettier-eslint --stdin-filepath % --trailing-comma all --single-quote<CR>
nnoremap <leader>iu :IstanbulUpdate <CR>
nnoremap <leader>it :IstanbulToggle <CR>

" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp\|coverage$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
\ }

au BufNewFile,BufRead *.vue setf vue.html.javascript.css
au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2
" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:> foldmethod=indent nofoldenable
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

iab setheader #!/usr/bin/env python<CR># encoding=utf8<CR># made by zodman


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




let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" language tool plugin
let g:languagetool_jar='$HOME/LanguageTool-4.9.1/languagetool-commandline.jar'
" Snippets
let g:UltiSnipsListSnippets="<c-w>"

" HARDTIME
let g:list_of_normal_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
" ENABLE FOR DEFAULT
let g:hardtime_default_on = 1



let g:PaperColor_Theme_Options = {
  \   'theme': {
  \     'default.dark': {
  \       'transparent_background': 1,
  \       'allow_bold': 1,
  \       'allow_italic': 1
  \     }
  \   }
  \ }

let g:gruvbox_contrast_dark='hard'


" Enable true color 启用终端24位色
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" the configuration options should be placed before `colorscheme sonokai`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colo sonokai



