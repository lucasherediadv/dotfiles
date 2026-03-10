if has("eval")
  let skip_defaults_vim = 1
endif

set nocompatible

" automatically indent new lines
set autoindent

" replace tabs with spaces automatically
set expandtab

" number of spaces to replace a tab with when expandtab
set tabstop=2

" smart case
set ignorecase
set smartcase

" automatically write files when changing when multiple files open
set autowrite

" deactivate line numbers
set nonumber

" turn col and row position on in bottom right
set ruler

" disable bell (also disable in .inputrc)
set noerrorbells
set visualbell
set vb t_vb=

set softtabstop=2

" mostly used with >> and <<
set shiftwidth=2

set smartindent

set smarttab

" disable relative line numbers
set norelativenumber

" disable spellcapcheck
set spc=

" more risky, but cleaner
set nobackup
set noswapfile
set nowritebackup
set viminfofile=NONE

set linebreak

" not a fan of bracket matching or folding
if has("eval") " vim-tiny detection
  let g:loaded_matchparen=1
endif
set noshowmatch

" wrap around when searching
set wrapscan
set nowrap

" stop complaints about switching buffer with changes
set hidden

" here because plugins and stuff need it
syntax enable

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" no status line
set laststatus=0
