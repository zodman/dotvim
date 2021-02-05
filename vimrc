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
set hidden


"VUE
"Polyglot
"let g:polyglot_disabled = ['vue',]



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
Plug 'sheerun/vim-polyglot' " hightlight for files
Plug 'jlanzarotta/bufexplorer'
Plug 'gregsexton/matchtag'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/indentLine'
Plug 'moll/vim-bbye' " Bdelete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sjl/splice.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
"" OTHER LANGUAGUAGES
" Plug 'othree/html5.vim' replace by polyglot
Plug 'posva/vim-vue' " replace by polyglot
Plug 'yuezk/vim-js'
Plug 'yasuhiroki/github-actions-yaml.vim'
"Plug 'stanangeloff/php.vim'
" Plug 'cespare/vim-toml' "check if polyglot can replace
Plug 'retorillo/istanbul.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

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

let python_highlight_all=1
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

let g:solarized_termcolors=256

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


let g:airline#extensions#tabline#enabled = 1


" colorscheme gruvbox
"colo solarized
" colo PaperColor
colo badwolf

"let NERDTreeIgnore=['\.log$','junit\.xml$','\.serverless','\.git$','\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__', 'htmlcov','node_modules', '*report*', 'coverage', '^tags$', '\.egg-info','dist','^build$[[dir]]']
let NERDTreeIgnore=['\.log$','junit\.xml$','\.serverless','\.git$','\.swp$','\.pyc$','\.pyo$', '\.swo$','__pycache__', 'htmlcov','node_modules', '*report*', 'coverage', '^tags$', '\.egg-info','dist','my_data']
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1

" https://github.com/junegunn/fzf/issues/453#issuecomment-513495518
"au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif
" au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | endif

" FZF
nmap <C-P> :GFiles<CR>

set pastetoggle=<F3>
noremap <F4> :!ctags -R<CR>
noremap <F2> :NERDTreeToggle<CR>
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
map <leader>a :e ~/.vim/alias.bash  <CR>
nnoremap gp :silent %!prettier-eslint --stdin-filepath % --trailing-comma all --single-quote<CR>
autocmd FileType javascript nnoremap <leader>iu :IstanbulUpdate <CR>
autocmd FileType javascript nnoremap <leader>it :IstanbulToggle <CR>
autocmd FileType python nnoremap <leader>iu :Coveragepy refresh <CR>


" Edit vimr configuration file
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>


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

let g:indentLine_enabled = 1


let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" language tool plugin
" use choco to install it.n
let g:languagetool_cmd='languagetool'
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
"if exists('+termguicolors')
  "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  "set termguicolors
"endif


" the configuration options should be placed before `colorscheme sonokai`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colo sonokai


" langserver configuration
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

let g:ackprg = 'ag --vimgrep'
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
set grepprg=ag\ --nogroup\ --nocolor

