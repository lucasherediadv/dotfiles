case $- in
*i*) ;; # Interactive
*) return ;;
esac

# Environment variables
export PAGER=less
export LESSHISTFILE=/dev/null
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox
export REPOS=$HOME/repos
export GITUSER="lucasherediadv"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export SCRIPTS="$GHREPOS/scripts/bin"

# Go
export CGO_ENABLED=0
export GOPROXY=direct
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/share/go/bin"

# Java
export JAVA_HOME=/usr/lib/jvm/default

# $CDPATH
export CDPATH=".:$HOME:$REPOS/github.com:$GHREPOS:$DOTFILES"

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

pathappend "$SCRIPTS" "$GOBIN" "$JAVA_HOME/bin"

# Bash shell options
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s checkwinsize
shopt -s expand_aliases

# History
set -o vi
shopt -s cmdhist
shopt -s histappend
export HISTSIZE=500000
export HISTFILESIZE=100000
export PROMPT_COMMAND='history -a'
export HISTCONTROL="erasedups:ignoreboth"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Functions
clone() {
  local repo="$1" user
  local repo="${repo#https://github.com/}"
  local repo="${repo#git@github.com:}"
  if [[ $repo =~ / ]]; then
    user="${repo%%/*}"
  else
    user="$GITUSER"
    [[ -z "$user" ]] && user="$USER"
  fi
  local name="${repo##*/}"
  local userd="$REPOS/github.com/$user"
  local path="$userd/$name"
  [[ -d "$path" ]] && cd "$path" && return
  mkdir -p "$userd"
  cd "$userd"
  echo gh repo clone "$user/$name" -- --recurse-submodule
  gh repo clone "$user/$name" -- --recurse-submodule
  cd "$name"
} && export -f clone

# Aliases
unalias -a
alias vi='vim'
alias clear='clear -x'
alias ls='ls --color=auto --group-directories-first -F'

# Use bash-completion, if available, and avoid double-sourcing
[[ $PS1 &&
! ${BASH_COMPLETION_VERSINFO:-} &&
-f /usr/share/bash-completion/bash_completion ]] &&
. /usr/share/bash-completion/bash_completion

# Initialize starship only if the binary is available in the system
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi
