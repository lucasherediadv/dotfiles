#!/bin/bash
# shellcheck disable=SC1091

case $- in
*i*) ;; # Interactive
*) return ;;
esac

# ----------------------- Environment variables ----------------------

# Pager
export PAGER=less
export BAT_THEME=gruvbox-dark
export LESSHISTFILE=/dev/null

# Editor
export EDITOR=vim
export VISUAL=vim
# export EDITOR=nvim
# export VISUAL=nvim

# Repositories
export REPOS=$HOME/repos
export GITUSER="lucasherediadv"
export GHREPOS="$REPOS/github.com/$GITUSER"

# Dotfiles
export DOTFILES="$GHREPOS/dotfiles"

# Scripts
export SCRIPTS="$GHREPOS/scripts/bin"

# Go
export CGO_ENABLED=0
export GOPROXY=direct
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/share/go/bin/"

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

pathappend "$SCRIPTS" "$GOBIN" "$HOME/.local/bin" "$JAVA_HOME/bin"

# ------------------------ Bash shell options ------------------------

shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s checkwinsize
shopt -s expand_aliases

# ------------------------------ History -----------------------------

set -o vi
shopt -s cmdhist
shopt -s histappend
export HISTSIZE=500000
export HISTFILESIZE=100000
export PROMPT_COMMAND='history -a'
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# ------------------------------ Aliases -----------------------------

unalias -a
alias vi='$EDITOR'
alias clear='clear -x'
alias ls='eza --icons --group-directories-first -F'
# alias ls='ls --color=auto --group-directories-first -F'

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

# Initialize starship only if the binary is available in the system
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
