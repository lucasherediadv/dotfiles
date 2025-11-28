#!/bin/bash
# shellcheck disable=SC1090,SC1091

case $- in
*i*) ;; # Interactive
*) return ;;
esac

# ----------------------- Environment variables ----------------------

export LANG="en_US.UTF-8"
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export REPOS="$HOME/repos"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$DOTFILES/scripts"

# Editor
export EDITOR=vim
export VISUAL=vim

# Pager
export PAGER=less
export LESS="-FXR"
export SYSTEMD_LESS="-FRXMK"
export LESSHISTFILE=/dev/null

# Go
export CGO_ENABLED=0
export GOPROXY=direct
export GOTELEMETRY=off

# CDPATH
export CDPATH=".:$GHREPOS:$DOTFILES:$REPOS:$HOME"

# ------------------------------- Path -------------------------------

pathappend() {
  declare arg
  for arg in "$@"; do
      test -d "$arg" || continue
      PATH=${PATH//":$arg:"/:}
      PATH=${PATH/#"$arg:"/}
      PATH=${PATH/%":$arg"/}
      export PATH="${PATH:+"$PATH:"}$arg"
  done
}

pathappend \
  "$GOBIN" \
  "$SCRIPTS"

# ------------------------ Bash shell options ------------------------

shopt -s checkwinsize globstar dotglob extglob

# -------------------------- stty annoyances -------------------------

stty -ixon # Disable control-s/control-q tty flow control

# ------------------------------ History -----------------------------

export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth

set -o vi
shopt -s histappend

# ------------------------------ Aliases -----------------------------

unalias -a
alias vi='vim'
alias free='free -h'
alias tree='tree -C'
alias ip='ip --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias clear='printf "\e[H\e[2J"'
alias ls='ls -hF --color=auto --group-directories-first'

# ------------- Source external dependencies / Completion ------------

[ -f "$HOME/.bash_private" ] && . "$HOME/.bash_private"
[ -f "/usr/share/bash-completion/bash_completion" ] && . "/usr/share/bash-completion/bash_completion"
