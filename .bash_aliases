#!/usr/bin/env bash

# Core
alias l="ls -l --color=auto"
alias ll="ls -all --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias s="source"
alias c="clear"
alias e="exit"
alias mv='mv -v'
alias mv='cp -v'
alias mv='rm -v'
alias n=nvim
alias venv="source .venv/bin/activate"

# Files/Dirs
alias todo="nvim Documents/TODO.md"
alias pp="cd ~/Documents/python_projects"

# Git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gp='git push'
