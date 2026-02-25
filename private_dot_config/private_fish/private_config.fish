set -g fish_greeting

set -gx PAGER less
set -gx LESSHISTFILE /dev/null

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx BROWSER firefox

set -gx REPOS $HOME/repos
set -gx GITUSER lucasherediadv
set -gx GHREPOS $REPOS/github.com/$GITUSER

set -gx SCRIPTS $GHREPOS/scripts
set -gx DOTFILES $GHREPOS/dotfiles

set -gx CDPATH .:$GHREPOS:$REPOS/github.com:$HOME

if status is-interactive
    fish_vi_key_bindings

    abbr df duf
    abbr v nvim
    abbr vi nvim
    abbr vim nvim
    abbr p podman
    abbr du du -h
    abbr cz chezmoi
    abbr c clear -x
    abbr clear clear -x
    abbr free free -h -m
    abbr ip ip --color=auto
    abbr pstree pstree -UC age
    abbr diff diff --color=auto
    abbr grep grep --color=auto
    abbr psc ps xawf -eo pid,user,cgroup,args
    abbr ls eza --icons --group-directories-first -F
    abbr l eza --icons --group-directories-first -aF
    abbr la eza --icons --group-directories-first -aF
    abbr ll eza --icons --group-directories-first -alF
    abbr tree eza --icons --group-directories-first --tree --ignore-glob=.git -aF

    abbr todo $EDITOR $HOME/.todo.md
    abbr to bat $HOME/.todo.md

    abbr me cd $GHREPOS
    abbr dot cd $DOTFILES
    abbr scripts cd $SCRIPTS/bin
    abbr ghrepos cd $REPOS/github.com

    abbr g git
    abbr lg lazygit
    abbr gs git status
    abbr gl git log --graph --decorate --oneline

    abbr b bat
    abbr cat bat

    abbr as atuin search

    abbr nb newsboat

    atuin init fish | source
    starship init fish | source
end
