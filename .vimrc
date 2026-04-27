" Prevent vim from loading the systemd-wide default configuration
if has("eval")
  let g:skip_defaults_vim = 1
endif

" Disable vi compatibility, if for some reason it's on
if &compatible
  set nocompatible
endif

" Use colors that look good on dark backgrounds
set background=dark

" True color support
if exists('+termguicolors')
  set termguicolors
endif

" Highlight search hits
set hlsearch
set linebreak

" While typing a search command, show where the pattern, as it was typed so far, matches
set incsearch

" Use CTRL-L to clear the highlighting of 'hlsearch' and call :diffupdate
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" No status line
set laststatus=0

" Turn col and row position on in bottom right
set ruler

" Determines the content of the ruler string
set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" Better ascii friendly listchars
if v:version >= 800
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
endif

set autoread

" Automatically indent new lines
set autoindent

" Replace tabs with spaces automatically
set expandtab

" Number of spaces to replace a tab with when expandtab
set tabstop=2

set ignorecase

set smartcase

" Automatically write files when changing when multiple files open
set autowrite

" Deactivate line numbers
set nonumber
set norelativenumber

" Disable bell (also disable in .inputrc)
set noerrorbells
set visualbell
set vb t_vb=

set softtabstop=2

" Mostly used with >> and <<
set shiftwidth=2

set smartindent

set smarttab

" Disable spellcapcheck
set spc=

" More risky, but cleaner
set nobackup
set noswapfile
set nowritebackup
set viminfofile=NONE

set linebreak

" Not a fan of bracket matching
if has("eval")
  let g:loaded_matchparen=1
endif

set noshowmatch

" Mark trailing spaces as errors
match Visual '\s\+$'

set wrap

" Stop complaints about switching buffer with changes
set hidden

" Here because plugins and stuff need it
syntax enable

" Faster scrolling
set ttyfast

" Allow sensing the filetype
filetype plugin on

" Enable spell checking for arbitrary file types
autocmd BufRead,BufNewFile *.{txt,md,adoc} set spell
