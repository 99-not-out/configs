set nocompatible

execute pathogen#infect()

if has("gui_macvim")
  " set macvim specific stuff
  execute pathogen#infect('mvim_only_bundle/{}')

  syntax enable
  set background=light
  colorscheme PaperColor
  
  let g:gitgutter_map_keys = 0
  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 1
  let g:airline_highlighting_cache = 1

  set cursorline number laststatus=2

  " Rooter
  let g:rooter_use_lcd = 1
  let g:rooter_silent_chdir = 1

  " SuperTab
  autocmd FileType *
        \ if &omnifunc != '' |
        \   call SuperTabChain(&omnifunc, "<c-p>") |
        \ endif

  let g:SuperTabLongestEnhanced = 1
  let g:SuperTabCrMapping = 1
  let g:SuperTabLongestHighlight = 1
  let g:SuperTabClosePreviewOnPopupClose = 1

  nnoremap <Leader>gb :Gbrowse<CR>
  nnoremap <Leader>t :RunTests<CR>:copen<CR>

  " FZF
  nnoremap <Leader>/ :Ag<CR>
  nnoremap <Leader>? :History/<CR>
  nnoremap <Leader>; :History:<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>d :BTags<CR>
  nnoremap <Leader>D :Tags!<CR>
  nnoremap <Leader>f :Files<CR>
  nnoremap <Leader>h :History<CR>
  nnoremap <Leader>l :BLines<CR>

  let g:fzf_buffers_jump = 1
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)
  let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
endif

""
"" General VIM Settings
""

filetype plugin indent on

set  hidden       incsearch     hlsearch         ignorecase  smartcase
set  tabstop=2    shiftwidth=2  expandtab        ruler       wildmenu
set  path+=**     history=1000  undolevels=1000  nobackup    noswapfile
set  scrolloff=3  showcmd

set completeopt=longest,menuone
set backspace=indent,eol,start
set wildmode=list:longest

let g:netrw_list_hide=netrw_gitignore#Hide()

if executable('ag')
  set grepprg=ag\ --vimgrep
endif

""
"" Custom key mappings
""

" Normal mode leader mappings
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>. :grep! -w '<C-R><C-W>'<CR>:cw<CR>

nmap <Leader><Leader>S <Plug>(easymotion-overwin-f2)
nmap <Leader><Leader>l <Plug>(easymotion-overwin-line)

" Quickfix mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'

