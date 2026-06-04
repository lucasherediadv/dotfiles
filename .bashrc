#!/bin/bash
# shellcheck disable=SC1091

case $- in
*i*) ;; # Interactive
*) return ;;
esac

# ----------------------- Environment variables ----------------------

# Pager
export PAGER=less
export LESSHISTFILE=/dev/null

# Editor
export EDITOR=vim
export VISUAL=vim

# Repositories
export REPOS=$HOME/repos
export GITUSER="lucasherediadv"
export GHREPOS="$REPOS/github.com/$GITUSER"

# Dotfiles
export DOTFILES="$GHREPOS/dotfiles"

# Scripts
export SCRIPTS="$GHREPOS/scripts/bin"

# Java
export JAVA_HOME=/usr/lib/jvm/default

# ------------------------------ $CDPATH -----------------------------

export CDPATH=".:$HOME:$REPOS/github.com:$GHREPOS:$DOTFILES"

# ------------------------------- $PATH ------------------------------

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

pathappend "$SCRIPTS" "$JAVA_HOME/bin"

# ------------------------ Bash shell options ------------------------

shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s checkwinsize
shopt -s expand_aliases

# ------------------------------ History -----------------------------

set -o vi
shopt -s histappend
export HISTSIZE=500000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth

# ------------------------------ Aliases -----------------------------

unalias -a
alias vi='$EDITOR'
alias clear='clear -x'
alias ls='ls --color=auto --group-directories-first -F'

# -------------------- Personalized configuration --------------------

[ -f "$HOME/.bash_personal" ] && . "$HOME/.bash_personal"
[ -f "$HOME/.bash_private" ] && . "$HOME/.bash_private"
[ -f "$HOME/.bash_work" ] && . "$HOME/.bash_work"

# ------------- Source external dependencies / completion ------------

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
  . /usr/share/bash-completion/bash_completion

# ------------------------------ Prompt ------------------------------

__ps1() {
  local P='$' u='\[\e[33m\]' p='\[\e[34m\]' b='\[\e[36m\]'
  local r='\[\e[31m\]' h='\[\e[34m\]' w='\[\e[35m\]' x='\[\e[0m\]' g='\[\e[38;2;90;82;76m\]'
  local dir="${PWD##*/}" B

  [[ $PWD = / ]] && dir=/
  [[ $PWD = "$HOME" ]] && dir='~'

  B=$(git branch --show-current 2>/dev/null)

  if [[ -n $B ]]; then
    [[ $dir = "$B" ]] && B=.
    [[ $B = master || $B = main ]] && b=$r
    B="$g($b$B$g)"
  fi

  PS1="$g$u\u$g@$h\h$g:$w$dir$B\n$g$p$P$x "
}

PROMPT_COMMAND='__ps1'
