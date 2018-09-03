set nocompatible

execute pathogen#infect()

if executable('ag')
  set grepprg=ag\ --vimgrep
endif

filetype plugin indent on

syntax enable
set background=light
colorscheme PaperColor

set  hidden       incsearch     hlsearch      ignorecase       smartcase
set  tabstop=2    shiftwidth=2  expandtab     ruler            number     wildmenu
set  path+=**     laststatus=2  history=1000  undolevels=1000  nobackup   noswapfile
set  scrolloff=3  showcmd       cursorline

set completeopt=longest,menuone
set backspace=indent,eol,start

let g:netrw_list_hide=netrw_gitignore#Hide()
let g:gitgutter_map_keys = 0
let g:fzf_buffers_jump = 1
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1


" Custom key mappings

" Normal mode leader mappings
nnoremap <Leader>/ :Ag<CR>
nnoremap <Leader>? :History/<CR>
nnoremap <Leader>; :History:<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>D :Tags!<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>t :RunTests<CR>:copen<CR>

nmap s <Plug>(easymotion-overwin-f2)

" Quickfix mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Ctrl-F mappings (searching)
nmap <C-F>f <Plug>CtrlSFPrompt
vmap <C-F>f <Plug>CtrlSFVwordExec
nmap <C-F>n <Plug>CtrlSFCwordPath
nmap <C-F>p <Plug>CtrlSFPwordPath
nmap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" Rooter
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1

" Tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabLongestEnhanced = 1
let g:SuperTabCrMapping = 1
let g:SuperTabLongestHighlight = 1
let g:SuperTabClosePreviewOnPopupClose = 1
