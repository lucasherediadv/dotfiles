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
