" VIM VIM VIM VIM VIM VIM VIM VIM VIM

set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on

" Appearance
set number
set relativenumber
" set termguicolors

" Tabs / Indentations
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smartindent
set expandtab
set nowrap

" Search
set ignorecase
set incsearch
set smartcase

" Layout
set cmdheight=1
set scrolloff=12
set completeopt="menuone, noinsert, noselect"

" enable auto completion menu after pressing tab
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Behavior

set hidden
set noerrorbells
set noswapfile
set nobackup
set splitright
set splitbelow
set noautochdir
set modifiable
set clipboard+=unnamedplus
