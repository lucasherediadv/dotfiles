if has("eval")
  let skip_defaults_vim = 1
endif

set background=dark

if exists('+termguicolors')
  set termguicolors
endif

let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

set cursorline

" Disable vi compatibility, if for some reason it's on
if &compatible
  set nocompatible
endif

" Check if an option was set from a file in $HOME.  This lets us avoid
" overriding options in the user's vimrc, but still override options in the
" system vimrc.
function! s:MaySet(option) abort
  if exists('*execute')
    let out = execute('verbose setglobal all ' . a:option . '?')
  else
    redir => out
    silent verbose execute 'setglobal all' a:option . '?'
    redir END
  endif
  return out !~# " \\(\\~[\\/]\\|Lua\\)[^\n]*$"
endfunction

if s:MaySet('backspace')
  set backspace=indent,eol,start
endif

" Disable completing keywords in included files (e.g., #include in C).  When
" configured properly, this can result in the slow, recursive scanning of
" hundreds of files of dubious relevance.
set complete-=i
if s:MaySet('smarttab')
  set smarttab
endif

set nrformats-=octal

if has ('realtime') && s:MaySet('incsearch')
  set incsearch
endif

" highlight search hits
set hlsearch
set linebreak

" Make the escape key more responsive by decreasing the wait time for an
" escape sequence (e.g., arrow keys).
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Use CTRL-L to clear the highlighting of 'hlsearch' (off by default) and call
" :diffupdate
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

if s:MaySet('laststatus')
  set laststatus=0
endif
if s:MaySet('ruler')
  set ruler
endif
if s:MaySet('wildmenu')
  set wildmenu
endif

if s:MaySet('scrolloff')
  set scrolloff=1
endif
if s:MaySet('sidescroll') && s:MaySet('sidescrolloff')
  set sidescroll=1
  set sidescrolloff=2
endif
set display+=lastline
if has('patch-7.4.2109')
  set display+=truncate
endif

if s:MaySet('listchars')
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if s:MaySet('autoread')
  set autoread
endif

if !(exists('g:did_load_filetypes') && exists('g:did_load_ftplugin') && exists('g:did_indent_on'))
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif


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
" set ruler

" Disable bell (also disable in .inputrc)
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

" not a fan of bracket matching
if has("eval") " vim-tiny detection
  let g:loaded_matchparen=1
endif
set noshowmatch

if v:version >= 800
  " Stop vim from silently messing with files that it shouldn't
  set nofixendofline

  " I hate automatic folding
  set foldmethod=manual
  set nofoldenable
endif

" mark trailing spaces as errors (break Makefiles, etc.)
match Visual '\s\+$'

set wrap

" stop complaints about switching buffer with changes
set hidden

" here because plugins and stuff need it
syntax enable

" faster scrolling
set ttyfast

" allow sensing the filetype
filetype plugin on

" no status line
" set laststatus=0
