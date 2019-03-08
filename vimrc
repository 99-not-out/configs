set nocompatible

execute pathogen#infect()

""
"" General VIM Settings
""
filetype plugin indent on
set background=light
set mouse=a

set  hidden       incsearch     hlsearch         ignorecase    smartcase
set  tabstop=2    shiftwidth=2  expandtab        ruler         wildmenu
set  path+=**     history=1000  undolevels=1000  nobackup      noswapfile
set  scrolloff=3  showcmd

set completeopt=longest,menuone
set backspace=indent,eol,start
set wildmode=list:longest

" some options don't work between GUI and TTY vim, so don't save the options
set sessionoptions=buffers,curdir,folds,winsize

let g:netrw_list_hide=netrw_gitignore#Hide()

set grepprg=ag

""
"" set macvim specific stuff
""
if has("gui_macvim")
  execute pathogen#infect('mvim_only_bundle/{}')

  colorscheme PaperColor
  syntax enable

  set number cursorline
  set laststatus=2
  set updatetime=500

  let g:startify_change_to_dir = 0
  let g:startify_change_to_vcs_root = 1
  let g:airline_highlighting_cache = 1

  " open current session in iterm
  nnoremap <Leader>V :mks! ~/.vim/session/_xfer.vim<CR>:silent !osascript ~/open_vim.scpt<CR>
else
  syntax off
  set laststatus=0
  hi Search cterm=NONE ctermfg=black ctermbg=white

  " open current file in mvim
  nnoremap <Leader>v :!env -i HOME="$HOME" bash -l -c 'mvim %'<CR>
  " open current session in mvim
  nnoremap <Leader>V :mks! ~/.vim/session/_xfer.vim<CR>:!env -i HOME="$HOME" bash -l -c 'mvim -S ~/.vim/session/_xfer.vim'<CR>
endif

""
"" Custom key mappings
""

" Normal mode leader mappings
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>n :noh<CR>:set nospell<CR>
nnoremap <Leader>S :setlocal spell spelllang=en_gb<CR>
vmap <Leader>y "+y



" Quickfix mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'

" Fireplace
nnoremap <Leader>r :w<CR>:Require<CR>
nnoremap <Leader>x :w<CR>:SyntasticCheck<CR>
nnoremap <Leader>R :wa<CR>:Require!<CR>
nnoremap <Leader>t :w<CR>:Require<CR>:.RunTests<CR>:copen<CR>
nnoremap <Leader>T :w<CR>:Require<CR>:RunTests<CR>:copen<CR>

" Matchmaker
let g:matchmaker_enable_startup = 1
let g:matchmaker_ignore_single_match = 1
hi Matchmaker guibg=white ctermbg=white

" Gutentags
let g:gutentags_file_list_command = 'fd -tf'

" FZF
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>D :Tags!<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :GFiles?<CR>

let g:fzf_buffers_jump = 1
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Syntastic

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_clojure_checkers = ['eastwood']

let g:syntastic_mode_map = {
        \ "mode": "active",
        \ "active_filetypes": [],
        \ "passive_filetypes": ["clojure"] }


" Local mods

nnoremap <leader>s :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>s :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif
    silent execute "grep! -R " . shellescape(@@) . " ."
    copen
    let @@ = saved_unnamed_register
endfunction
