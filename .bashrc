case $- in
*i*) ;;
*) return ;;
esac

# Environment variables
export PAGER=less
export LESSHISTFILE=/dev/null
export EDITOR=vim
export EDITOR=vim
export BROWSER=firefox
export REPOS=$HOME/repos
export GITUSER="lucasherediadv"
export GHREPOS="$REPOS/github.com/$GITUSER"
export SCRIPTS="$GHREPOS/scripts"
export DOTFILES="$GHREPOS/dotfiles"

# $CDPATH
export CDPATH=".:$GHREPOS:$DOTFILES:$REPOS/github.com:$HOME"

# $PATH
pathappend() {
  declare arg
  for arg in "$@"; do
    test -d "$arg" || continue
    PATH=${PATH//":$arg:"/:}
    PATH=${PATH/#"$arg:"/}
    PATH=${PATH/%":$arg"/}
    export PATH="${PATH:+"$PATH:"}$arg"
  done
} && export -f pathappend

pathappend "$SCRIPTS/bin"

# Bash options
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s checkwinsize
shopt -s expand_aliases

# History
set -o vi
shopt -s histappend
export HISTCONTROL=ignoreboth

# Aliases
unalias -a
alias vi='vim'
alias clear='clear -x'
alias ls='ls --color=auto --group-directories-first -F'
