set nocompatible

execute pathogen#infect()

""
"" General VIM Settings
""
filetype plugin indent on
set background=light

set hidden       incsearch     hlsearch         ignorecase      smartcase
set tabstop=2    shiftwidth=2  expandtab        ruler           wildmenu
set path+=**     history=1000  undolevels=1000  nobackup        noswapfile
set scrolloff=3  showcmd       

set completeopt=longest,menuone
set backspace=indent,eol,start
set wildmode=list:longest

" some options don't work between GUI and TTY vim, so don't save the options
set sessionoptions=buffers,curdir,folds,winsize

let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_banner=0
let g:netrw_liststyle=3

set grepprg=ag

""
"" set macvim specific stuff
""
if has("gui_macvim")
"  execute pathogen#infect('mvim_only_bundle/{}')

  set laststatus=2 updatetime=500 number cursorline

  colorscheme PaperColor
  syntax enable

  " open current session in iterm
  nnoremap <Leader>V :mks! ~/.vim/session/_xfer.vim<CR>:silent !osascript ~/open_vim.scpt<CR>
else
  syntax off
  hi Search ctermfg=black ctermbg=darkgrey

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
nnoremap <Leader>e :Explore<CR>
nnoremap <Leader>g :!git status<CR>
nnoremap <Leader>n :noh<CR>:set nospell<CR>
nnoremap <Leader>S :setlocal spell spelllang=en_gb<CR>
vmap <Leader>y "+y

" Quickfix mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'

" Fireplace
nnoremap <Leader>r :w<CR>:Require<CR>
nnoremap <Leader>R :wa<CR>:Require!<CR>
nnoremap <Leader>t :w<CR>:Require<CR>:.RunTests<CR>:copen<CR>
nnoremap <Leader>T :w<CR>:Require<CR>:RunTests<CR>:copen<CR>

" Matchmaker
let g:matchmaker_enable_startup = 1
let g:matchmaker_ignore_single_match = 1
hi Matchmaker guibg=white
hi Matchmaker ctermbg=white

" Gutentags
let g:gutentags_file_list_command = 'fd -tf'

" FZF
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>D :Tags!<CR>
nnoremap <Leader>f :Files<CR>

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

" ALE
let g:ale_lint_on_text_changed = 'never'

" Local mods
"
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

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

