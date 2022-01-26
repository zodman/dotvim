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
Plug 'jlanzarotta/bufexplorer'
""Plug 'gregsexton/matchtag'
Plug 'bronson/vim-trailing-whitespace'
Plug 'mileszs/ack.vim'  " replace with <leader>ag
Plug 'Yggdroot/indentLine'
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
endif
Plug 'moll/vim-bbye' " Bdelete
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'bling/vim-bufferline'
"" Plug 'sjl/splice.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'preservim/tagbar'
Plug 'jmcantrell/vim-diffchanges'


""" OTHER LANGUAGUAGES
Plug 'yasuhiroki/github-actions-yaml.vim'
""Plug 'stanangeloff/php.vim'
"" Plug 'cespare/vim-toml' "check if polyglot can replace
""Plug 'retorillo/istanbul.vim'
Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }


Plug 'pantharshit00/vim-prisma'
Plug 'jparise/vim-graphql'
Plug 'hashivim/vim-terraform'

"" Snippets
"Plug 'isRuslan/vim-es6'
"Plug 'joaohkfaria/vim-jest-snippets'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mlaursen/vim-react-snippets', {'branch': 'main'}
""THEMES
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/sonokai'
Plug 'tomasr/molokai'
Plug 'bluz71/vim-moonfly-colors'
Plug 'jonathanfilip/vim-lucius'
Plug 'joshdick/onedark.vim'
Plug 'sjl/badwolf'
Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'
Plug 'projekt0n/github-nvim-theme'


""" " Pythons
Plug 'vim-scripts/indentpython.vim'
" Plug 'mgedmin/coverage-highlight.vim'
Plug 'raimon49/requirements.txt.vim'
Plug 'mindriot101/vim-yapf'
Plug 'vim-python/python-syntax'

"""Plug 'digitaltoad/vim-pug'
"" WRITING
Plug 'dpelle/vim-LanguageTool'
Plug 'takac/vim-hardtime'

Plug 'mnishz/colorscheme-preview.vim'
Plug 'ruanyl/vim-gh-line'

Plug 'wakatime/vim-wakatime'

Plug 'Shougo/echodoc.vim'
Plug 'sjl/splice.vim'


call plug#end()            " required

" echodoc
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'


filetype plugin indent on    " required
filetype plugin on
" automplete
" To use omni completion, type <C-X><C-O> while open in Insert mode. If
" matching names are found, a pop-up menu opens which can be navigated using
" the <C-N> and <C-P> keys.
"set omnifunc=syntaxcomplete#Complete
let  g:indentLine_setConceal=0



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
" // https://vi.stackexchange.com/a/19420
function! BSkipQuickFix(command)
  let start_buffer = bufnr('%')
  execute a:command
  while &buftype ==# 'quickfix' && bufnr('%') != start_buffer
    execute a:command
  endwhile
endfunction

nnoremap <silent> ,q :call BSkipQuickFix("bp")<CR>
nnoremap <silent> ,w :call BSkipQuickFix("bn")<CR>

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
nnoremap gp :%!npx prettier --stdin-filepath %<CR>
autocmd FileType javascript nnoremap <leader>iu :IstanbulUpdate <CR>
autocmd FileType javascript nnoremap <leader>it :IstanbulToggle <CR>
autocmd FileType python nnoremap <leader>iu :Coveragepy refresh <CR>


" Edit vimr configuration file
nnoremap <Leader>ve :e ~/.vim/vimrc<CR>
" Reload vimr configuration file
nnoremap <Leader>vr :source $MYVIMRC<CR>

nnoremap <Leader>co :copen<CR>
nnoremap <Leader>cc :cclose<CR>


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
" Fix identitation on filetypes
autocmd FileType javascriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescriptreact setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sts=2 sw=2 expandtab

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:> foldmethod=indent nofoldenable
autocmd FileType prisma,graphql setlocal ts=2 sts=2 sw=2 expandtab foldmethod=indent nofoldenable
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix

iab setheader #!/usr/bin/env python<CR># encoding=utf8<CR># made by zodman
iab nocheck // @ts-nocheck
iab zodman // made by zodman
iab noconsole // eslint-disable-next-line no-console


" https://github.com/webpack/webpack/issues/781#issuecomment-95523711
set backupcopy=yes

let g:indentLine_enabled = 1
set conceallevel=2

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
"let g:UltiSnipsExpandTrigger="<tab>"
"

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
"let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colo molokai


" langserver configuration
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'vue': ['vls'],
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'typescriptreact': ['typescript-language-server', '--stdio', '--log-level=4', '--tsserver-log-file=/tmp/ts.log', '--tsserver-log-verbosity=verbose'],
    \ 'typescript': ['typescript-language-server', '--stdio', '--log-level=4', '--tsserver-log-file=/tmp/ts.log', '--tsserver-log-verbosity=verbose'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'typescript.tsx': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls', '-vvvv', '--log-file=/tmp/pyls.log'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ }

"let g:LanguageClient_diagnosticsList="Location"
function SetLSPShortcuts()
  "Goto definition under cursor.
  nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent>gd :call LanguageClient#textDocument_definition()<CR>
"Rename identifier under cursor.
  nnoremap <leader>lr :LanguageClientStop<CR>:LanguageClientStart<CR>
" Format current document.
  nnoremap <leader>lf :%!npx prettier --stdin-filepath %<CR>
"Goto type definition under cursor.
  nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
"List all references of identifier under cursor.
  nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>

  "Get a list of completion items at current editing location.
  nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
  "Show type info (and short doc) of identifier under cursor.
  nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
  "List of current buffer's symbols.
  nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
  "nnoremap <leader>la :call LanguageClient_textDocument_<CR>

  " menu
  nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>
  nnoremap <leader>l :call LanguageClient_contextMenu()<CR>

   map <leader>i :call LanguageClient#explainErrorAtPoint()<CR>
   nnoremap <leader>ln :call LanguageClient_diagnosticsNext()<CR>
   nnoremap <leader>lp :call LanguageClient_diagnosticsPrevious()<CR>
   "https://jameschambers.co.uk/vim-typescript-slow
"   set re=0
   set omnifunc=LanguageClient#complete
   set completefunc=LanguageClient#complete

endfunction()

call SetLSPShortcuts()

function DebugProfile() 
    profile start profile.log
    profile func *
    profile file *
endfunction()


"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"" press ctrl+o to jump back
""nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"nnoremap <silent> <leader>m :call LanguageClient_contextMenu()<CR>

" clear languageclient clutter
"nnoremap <leader>cg :sign unplace *<cr>

function! FzfAgCurrentWord()
  let l:word = expand('<cword>')
  call fzf#vim#ag(l:word)
endfunction

noremap <silent> <leader>ag :call FzfAgCurrentWord()<cr>



let g:ackprg = 'ag --vimgrep'
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
set grepprg=ag\ --nogroup\ --nocolor

nnoremap <Leader>bg :hi Normal guibg=NONE ctermbg=NONE " make backgroun transparent<CR>

let g:gh_open_command = 'wslview '

let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
"
"let $LANGUAGECLIENT_DEBUG=1
"let g:LanguageClient_loggingLevel='DEBUG'
"let g:LanguageClient_autoStart=0
"let g:LanguageClient_loggingFile =  expand('~/.local/share/nvim/LanguageClient.log') 
"let g:LanguageClient_waitOutputTimeout = 500
"let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
"let g:LanguageClient_loggingLevel = 'INFO'
"let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
