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

    abbr vi nvim
    abbr c clear -x
    abbr clear clear -x
    abbr todo $EDITOR $HOME/.todo.md
    abbr tree tree -a --dirsfirst -C -I .git/
    abbr ls eza --icons --group-directories-first -F
    abbr la eza --icons --group-directories-first -aF
    abbr ll eza --icons --group-directories-first -alF

    atuin init fish | source
    starship init fish | source
end
