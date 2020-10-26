set nocompatible

"" Make sure Macvim has the right PATH setup when launched
"" from the finder
let s:path = system("echo echo VIMPATH'${PATH}' | $SHELL -l")
let $PATH = matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')

""
"" Core VIM Settings
""
filetype plugin indent on

set hidden       incsearch     hlsearch         ignorecase      smartcase
set tabstop=2    shiftwidth=2  expandtab        ruler           wildmenu
set path+=**     history=1000  undolevels=1000  nobackup        noswapfile
set scrolloff=1  showcmd       foldlevel=99     number          updatetime=500
set cursorline   laststatus=2

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

""
"" Add a few optional core-VIM packages
""

packadd! cfilter
if has('syntax') && has('eval')
  packadd! matchit
endif

""
"" Add third party packages. All packs are in the optional folder so
"" they can be easily enabled / disabled here as required.
""

" Core usefulness packs
packadd! bufexplorer
packadd! fzf
packadd! fzf.vim
packadd! nerdtree
packadd! nerdtree-git-plugin
packadd! tagbar
packadd! vim-gutentags

""
"" set macvim specific stuff
""
if has("gui_macvim")
  syntax enable
  set macmeta mouse=a

  " IDE stuff
  packadd! vim-signify
  packadd! ale
"  packadd! vim-fireplace

  " Themes
  packadd! papercolor-theme
  packadd! vim-color-desert-night
else
  syntax off
  highlight CursorLine cterm=NONE
  highlight CursorLineNr cterm=NONE ctermbg=7
endif

""
"" Custom key mappings
""

" Normal mode leader mappings
nnoremap <silent> <F12> :ToggleBufExplorer<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>e :Ag <C-R><C-W><CR>
nnoremap <Leader>D :Tags<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :!git status -sb<CR>
nnoremap <Leader>n :noh<CR>:set nospell<CR>
nnoremap <Leader>s :BLines<CR>

" Quickfix buffer local mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'


""
"" Plugin Configs
""

" Gutentags
let g:gutentags_file_list_command = 'fd -tf'

" FZF
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
let g:fzf_preview_window = ['up:50%:hidden', 'ctrl-s']

" ALE
let g:ale_lint_on_text_changed = 'never'

" Bufexplorer
let g:bufExplorerShowRelativePath = 1
let g:bufExplorerDisableDefaultKeyMapping = 1

" NERDTree
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
nnoremap - :TagbarClose<CR>:NERDTreeFind<CR>
nnoremap <f3> :TagbarClose<CR>:NERDTreeToggle<CR>
nnoremap <f2> :NERDTreeClose<CR>:TagbarToggle<CR>


" Tagbar
let g:tagbar_left = 1
let g:tagbar_width = 31
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_compact = 1
let g:tagbar_show_balloon = 0
let g:tagbar_autopreview = 0
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_type_lisp = {
    \ 'kinds' : [
        \ 'f:functions',
        \ 'd:definitions',
        \ 'm:macros',
        \ 'a:multimethoda',
        \ 'b:methods',
        \ 'c:oncedefs',
        \ 't:tests'
    \ ]
\ }
let g:tagbar_type_clojure = {
    \ 'kinds' : [
        \ 'f:functions',
        \ 'd:definitions',
        \ 'm:macros',
        \ 'a:multimethoda',
        \ 'b:methods',
        \ 'c:oncedefs',
        \ 't:tests'
    \ ]
\ }


""
"" Local mods
""

" Load C files as C syntax, rather than C++ syntax
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

