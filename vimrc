set nocompatible

""
"" Core VIM Settings
""
filetype plugin indent on

set hidden       incsearch     hlsearch         ignorecase      smartcase
set tabstop=2    shiftwidth=2  expandtab        ruler           wildmenu
set path+=**     history=1000  undolevels=1000  nobackup        noswapfile
set scrolloff=1  showcmd       foldlevel=99     updatetime=500  cursorline
set laststatus=2

set completeopt=longest,menuone
set backspace=indent,eol,start
set wildmode=longest,full

set undofile
set undodir=~/.vim/undos

"" netrw settings
let g:netrw_list_hide=netrw_gitignore#Hide()
" Set line numbers in netrw
let g:netrw_bufsettings="noma nomod nu nowrap ro nobl"
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_hide=1

set grepprg=ag

"" Add a few optional core-VIM packages
packadd! cfilter
if has('syntax') && has('eval')
  packadd! matchit
endif

""
"" Add third party packages. All packs are in the optional folder so
"" they can be easily enabled / disabled here as required.
""

" Core usefulness packs
packadd! fzf
packadd! fzf.vim
packadd! vim-cursorword
packadd! vim-gutentags

""
"" set macvim specific stuff
""
if has("gui_running")
  source ~/.vim/macvimrc
else
  syntax off
  highlight CursorLine cterm=NONE
  highlight CursorLineNr cterm=NONE ctermbg=7
endif

""
"" Custom key mappings
""

" Normal mode leader mappings
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>D :Tags<CR>
nnoremap <Leader>e :BLines <C-R><C-W><CR>
nnoremap <Leader>E :Ag <C-R><C-W><CR>
nnoremap <Leader>f :BLines<CR>
nnoremap <Leader>g :!git status -sb<CR>
nnoremap <Leader>n :noh<CR>:set nospell<CR>
nnoremap <Leader>o :Files<CR>

nnoremap * :set iskeyword-=/<CR>*:set iskeyword+=/<CR>

" Quickfix buffer local mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'


""
"" Plugin Configs
""

" Gutentags
let g:gutentags_file_list_command = 'fd -tf'
let g:gutentags_trace = 0
let g:gutentags_ctags_executable = '/opt/homebrew/Cellar/ctags/5.8_2/bin/ctags'

" FZF
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-s']

""
"" Local mods
""

" Load C files as C syntax, rather than C++ syntax
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

