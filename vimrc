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


"VUE
"Polyglot
" let g:polyglot_disabled = ['vue', 'python']



if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" CORE
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'vim-syntastic/syntastic'
"Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'sheerun/vim-polyglot' " hightlight for files
Plug 'jlanzarotta/bufexplorer'
Plug 'gregsexton/matchtag'
Plug 'bronson/vim-trailing-whitespace'
"Plug 'ctrlpvim/ctrlp.vim' use fzf instead
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'
Plug 'moll/vim-bbye' " Bdelete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sjl/splice.vim'
Plug 'editorconfig/editorconfig-vim'

"" OTHER LANGUAGUAGES
" Plug 'othree/html5.vim' replace by polyglot
" Plug 'posva/vim-vue' " replace by polyglot
Plug 'yuezk/vim-js'
Plug 'yasuhiroki/github-actions-yaml.vim'
"Plug 'stanangeloff/php.vim'
" Plug 'cespare/vim-toml' "check if polyglot can replace
Plug 'retorillo/istanbul.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Snippets
Plug 'isRuslan/vim-es6'
Plug 'joaohkfaria/vim-jest-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"THEMES
Plug 'vim-airline/vim-airline'
Plug 'sainnhe/sonokai'
Plug 'tomasr/molokai'
Plug 'bluz71/vim-moonfly-colors'
Plug 'jonathanfilip/vim-lucius'
""Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
"" " Pythons
Plug 'vim-scripts/indentpython.vim'
Plug 'alfredodeza/coveragepy.vim'
Plug 'raimon49/requirements.txt.vim'
Plug 'mindriot101/vim-yapf'
""Plug 'digitaltoad/vim-pug'
" WRITING
Plug 'dpelle/vim-LanguageTool'
Plug 'takac/vim-hardtime'
Plug 'pechorin/any-jump.vim'
call plug#end()            " required
filetype plugin indent on    " required
filetype plugin on
" automplete
set omnifunc=syntaxcomplete#Complete

let g:python_highlight_all = 1
set conceallevel=0



"folding settings
set foldmethod=manual   "fold based on indent
"set foldnestmax=3       "deepest fold is 3 levels
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS,htmlcov,*report*,coverage/*,my_data/*
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
let g:syntastic_check_on_open = 0
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



" FZF
nmap <C-P> :FZF<CR>


" colorscheme gruvbox
"colo solarized
" colo PaperColor
"colo badwolf

"let NERDTreeIgnore=['\.log$','junit\.xml$','\.serverless','\.git$','\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__', 'htmlcov','node_modules', '*report*', 'coverage', '^tags$', '\.egg-info','dist','^build$[[dir]]']
let NERDTreeIgnore=['\.log$','junit\.xml$','\.serverless','\.git$','\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__', 'htmlcov','node_modules', '*report*', 'coverage', '^tags$', '\.egg-info','dist','my_data']
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1


nnoremap <silent> <F2> :NERDTreeToggle<CR>
set pastetoggle=<F3>
noremap <F4> :!ctags -R<CR>
nnoremap <F9> :SyntasticCheck<CR> :SyntasticToggleMode<CR> :w<CR>

nnoremap ,s :w!<CR>
nnoremap ,d   :bd<CR>
nnoremap ,D   :Bdelete<CR>

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
map <leader>a :e ~/.vim/alias.bash  <CR>
nnoremap gp :silent %!prettier-eslint --stdin-filepath % --trailing-comma all --single-quote<CR>
autocmd FileType javascript nnoremap <leader>iu :IstanbulUpdate <CR>
autocmd FileType javascript nnoremap <leader>it :IstanbulToggle <CR>
autocmd FileType python nnoremap <leader>iu :Coveragepy refresh <CR>


" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|node_modules\|log\|tmp\|coverage$|my_data\',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
\ }

au BufNewFile,BufRead *.vue setf vue.html.javascript.css
autocmd BufNewFile,BufReadPost *.jade set filetype=pug
autocmd BufNewFile,BufReadPost Bakefile set filetype=bash
autocmd BufNewFile,BufReadPost *.md set textwidth=80 conceallevel=0

au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2
" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=0 expandtab
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
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
" use choco to install it.n
let g:languagetool_jar='$HOME/.local/bin/languagetool-commandline.jar'
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

hi Normal guibg=NONE ctermbg=NONE

" COC configuration
" fix flickering left bar
set signcolumn=yes 
set cmdheight=2

" Use `lp` and `ln` for navigate diagnostics
nmap <silent> <leader>lp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <Plug>(coc-diagnostic-next)
"
" " Remap keys for gotos
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>lt <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lr <Plug>(coc-references)


