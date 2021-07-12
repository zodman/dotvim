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
set signcolumn=yes



"VUE
"Polyglot
let g:python_highlight_all = 1




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
""Plug 'gregsexton/matchtag'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'mileszs/ack.vim' replace with <leader>ag
Plug 'Yggdroot/indentLine'
Plug 'moll/vim-bbye' " Bdelete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'bling/vim-bufferline'
"" Plug 'sjl/splice.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
Plug 'jmcantrell/vim-diffchanges'


""" OTHER LANGUAGUAGES
"Plug 'yasuhiroki/github-actions-yaml.vim'
""Plug 'stanangeloff/php.vim'
"" Plug 'cespare/vim-toml' "check if polyglot can replace
""Plug 'retorillo/istanbul.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'dev',
    \ 'do': 'bash install.sh',
    \ }

"" Snippets
"Plug 'isRuslan/vim-es6'
"Plug 'joaohkfaria/vim-jest-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
""THEMES
Plug 'vim-airline/vim-airline'
Plug 'sainnhe/sonokai'
Plug 'tomasr/molokai'
Plug 'wojciechkepka/vim-github-dark'
Plug 'bluz71/vim-moonfly-colors'
Plug 'jonathanfilip/vim-lucius'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'

""" " Pythons
Plug 'vim-scripts/indentpython.vim'
Plug 'mgedmin/coverage-highlight.vim'
Plug 'raimon49/requirements.txt.vim'
Plug 'mindriot101/vim-yapf'
Plug 'vim-python/python-syntax'

"""Plug 'digitaltoad/vim-pug'
"" WRITING
Plug 'dpelle/vim-LanguageTool'
Plug 'takac/vim-hardtime'
call plug#end()            " required
filetype plugin indent on    " required
filetype plugin on
" automplete
" To use omni completion, type <C-X><C-O> while open in Insert mode. If
" matching names are found, a pop-up menu opens which can be navigated using
" the <C-N> and <C-P> keys.
"set omnifunc=syntaxcomplete#Complete
set omnifunc=LanguageClient#complete
set completefunc=LanguageClient#complete

let  g:indentLine_setConceal=0

" Polyglot
let g:polyglot_disabled = ['python']




"folding settings
set foldmethod=manual   "fold based on indent
"set foldnestmax=3       "deepest fold is 3 levels
set shortmess=atI " Shortens messages in status line.
set laststatus=2 " Always show status line.
set wildignore+=*.pyc,*.pyo,*.db,PYSMELLTAGS,htmlcov,*report*,coverage/*,my_data/*
set foldenable " Turn on folding.
set mouse=


if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


let g:airline#extensions#languageclient#enabled = 1
let g:airline#extensions#languageclient#show_line_numbers = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#enabled = 1


" colorscheme gruvbox
"colo solarized
" colo PaperColor
" colo badwolf

let NERDTreeIgnore=[
                \'\.log$','junit\.xml$','\.serverless','\.git$','\.swp$','\.pyc$','\.pyo$',
                \'\.swo$','__pycache__','htmlcov','node_modules','*report*',
                \'coverage', '^tags$','\.egg-info','dist','my_data','\.nyc_output$'
                \]
"let NERDTreeQuitOnOpen = 1
"let NERDTreeAutoDeleteBuffer = 1
"let NERDTreeMinimalUI = 1
"let NERDTreeDirArrows = 1
let NERDTreeShowHidden=0

" https://github.com/junegunn/fzf/issues/453#issuecomment-513495518
"au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif
" au BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | endif

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nmap <C-P> :GFiles<CR>
nmap <C-F> :Files<CR>
nmap <C-B> :Buffers<CR>
nnoremap <silent><leader>t :Tags -q <C-R>=expand("<cword>")<CR><CR>


set pastetoggle=<F3>
noremap <F4> :!ctags -R<CR>
noremap <F2> :NERDTreeToggle<CR>
" nnoremap <F9> :SyntasticCheck<CR> :SyntasticToggleMode<CR> :w<CR>
" syntastic disabled

nnoremap ,s :w!<CR>
nnoremap ,d :Bdelete<CR>

nnoremap <silent> ,q :bp<CR>
nnoremap <silent> ,w :bn<CR>

nnoremap <silent> ,1 :tabprev<CR>
nnoremap <silent> ,2 :tabnext<CR>
map ; :set cursorline<CR>:set cursorcolumn<CR>:set nocursorline<CR>:set nocursorcolumn<CR>



nnoremap _hd :set ft=htmldjango<CR>
nnoremap _dh :set ft=htmldjango<CR>
nnoremap _dt :set ft=htmldjango<CR>
nnoremap _pd :set ft=python.django<CR>
nnoremap _hb :set ft=handlebars<CR>
" ejecute last command
map <leader>l :<Up><CR>
map <leader>f :!prettier-eslint_d --write %:p<CR>
map <leader>a :e ~/.vim/alias.bash  <CR>
map <leader>i :call LanguageClient#explainErrorAtPoint()<CR>
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

au BufRead,BufNewFile .tmux.conf.local set filetype=tmux
au BufRead,BufNewFile *.vue set expandtab
au BufRead,BufNewFile *.vue set tabstop=2
au BufRead,BufNewFile *.vue set softtabstop=2
au BufRead,BufNewFile *.vue set shiftwidth=2
au FileType html setl sw=2 sts=2 et  
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
"let g:UltiSnipsListSnippets="<c-w>"

" HARDTIME
let g:list_of_normal_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []
" ENABLE FOR DEFAULT
let g:hardtime_default_on = 1



" COLORS
"
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


" wsl + tmux + vim
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif
" Enable true color 启用终端24位色
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set t_Co=256
  set termguicolors
endif


" running wsl + tmux + vim
let g:solarized_termcolors=256


" the configuration options should be placed before `colorscheme sonokai`
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colo molokai


" langserver configuration
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['pyls', '-vvvv', '--log-file=/tmp/pyls.log'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

let g:LanguageClient_diagnosticsList="Disabled"

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" press ctrl+o to jump back
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <leader>m :call LanguageClient_contextMenu()<CR>

" clear languageclient clutter
nnoremap <leader>cg :sign unplace *<cr>
function! FzfAgCurrentWord()
  let l:word = expand('<cword>')
  call fzf#vim#ag(l:word)
endfunction

noremap <silent> <leader>ag :call FzfAgCurrentWord()<cr>



let g:ackprg = 'ag --vimgrep'
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
set grepprg=ag\ --nogroup\ --nocolor

nnoremap <Leader>bg :hi Normal guibg=NONE ctermbg=NONE " make backgroun transparent<CR>

