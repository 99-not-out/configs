set nocompatible

if executable('ag')
  set grepprg=ag\ --vimgrep
endif

filetype plugin on
filetype plugin indent on

set hidden
set incsearch
set hlsearch
set ignorecase
set smartcase

set tabstop=2
set shiftwidth=2
set expandtab
set ruler

set number

let g:netrw_list_hide=netrw_gitignore#Hide()

set wildmenu
set path+=**
set laststatus=2
set history=1000
set undolevels=1000

set nobackup
set noswapfile

colorscheme papercolor
syntax on

nnoremap gr :grep! <cword><CR><CR>:copen<CR>

