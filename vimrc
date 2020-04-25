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
set scrolloff=1  showcmd       foldlevel=99

set mouse=a

set completeopt=longest,menuone
set backspace=indent,eol,start
set wildmode=longest,full

set undofile
set undodir=~/.vim/undos

" some options don't work between GUI and TTY vim, so don't save the options
set sessionoptions=buffers,curdir,folds,winsize

let g:netrw_list_hide=netrw_gitignore#Hide()
" Set line numbers in netrw
let g:netrw_bufsettings="noma nomod nu nowrap ro nobl"
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_hide=1

set grepprg=ag

""
"" set macvim specific stuff
""
if has("gui_macvim")
  set laststatus=2 updatetime=500 number cursorline
  set macmeta

  colorscheme PaperColor
  syntax enable
else
  syntax off
  hi Search        ctermfg=0  ctermbg=11
  hi VertSplit     ctermfg=15 ctermbg=0
  hi StatusLine    ctermfg=0  ctermbg=15
  hi StatusLineNC  ctermfg=8  ctermbg=7

  " open current file in mvim
  nnoremap <Leader>v :!env -i HOME="$HOME" bash -l -c 'mvim %'<CR>
  " open current session in mvim
  nnoremap <Leader>V :mks! ~/.vim/session/_xfer.vim<CR>:!env -i HOME="$HOME" bash -l -c 'mvim -S ~/.vim/session/_xfer.vim'<CR>
endif

""
"" Custom key mappings
""

" Normal mode leader mappings
nnoremap - :NERDTreeFind<CR>
nnoremap <C-_> :NERDTreeToggle<CR>
nnoremap <M-,> :BufSurfBack<CR>
nnoremap <M-.> :BufSurfForward<CR>
nnoremap <silent> <F12> :ToggleBufExplorer<CR>
nnoremap <Leader>A :Ag! <C-R><C-W><CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>d :BTags<CR>
nnoremap <Leader>D :Tags!<CR>
nnoremap <Leader>e :set operatorfunc=<SID>GrepOperator<cr>g@
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>g :!git status -sb<CR>
nnoremap <Leader>n :noh<CR>:set nospell<CR>
nnoremap <Leader>r :w<CR>:Require<CR>
nnoremap <Leader>R :wa<CR>:Require!<CR>
nnoremap <Leader>s :BLines<CR>
nnoremap <Leader>S :setlocal spell spelllang=en_gb<CR>
nnoremap <Leader>t :w<CR>:Require<CR>:RunTests<CR>
nnoremap <Leader>T :wa<CR>:Require!<CR>:RunTests<CR>
nnoremap <Leader>w :set wrap!<CR>
" Folding methods
nnoremap <Leader>zn :set foldmethod=manual<CR>
nnoremap <Leader>zs :set foldmethod=syntax<CR>
nnoremap <Leader>zi :set foldmethod=indent<CR>
nnoremap <Leader>zm :set foldmethod=marker<CR>
nnoremap <Space> zA

" Visual mode leader mappings
vnoremap <Leader>e :<c-u>call <SID>GrepOperator(visualmode())<cr>

" Quickfix buffer local mappings
nnoremap <expr> p &buftype ==# 'quickfix' ? "\<CR>\<C-w>j" : 'p'
nnoremap <expr> q &buftype ==# 'quickfix' ? "\<C-w>q" : 'q'


""
"" Plugin Configs
""

" Set clojure static indenting to match cljfmt
let g:clojure_align_subforms = 1

" Matchmaker
let g:matchmaker_enable_startup = 1
let g:matchmaker_ignore_single_match = 1
hi Matchmaker guibg=white
hi Matchmaker ctermbg=white

" Gutentags
let g:gutentags_file_list_command = 'fd -tf'


" FZF
let g:fzf_buffers_jump = 1
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)

" ALE
let g:ale_lint_on_text_changed = 'never'

" Bufexplorer
let g:bufExplorerShowRelativePath=1
let g:bufExplorerDisableDefaultKeyMapping=1

" Supertab
autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif


""
"" Local mods
""

augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

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
