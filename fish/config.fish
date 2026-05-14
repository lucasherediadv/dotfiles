set -gx PAGER less
set -gx LESSHISTFILE /dev/null
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER firefox
set -gx BAT_THEME gruvbox-dark
set -gx REPOS $HOME/repos
set -gx GITUSER lucasherediadv
set -gx GHREPOS "$REPOS/github.com/$GITUSER"
set -gx DOTFILES "$GHREPOS/dotfiles"
set -gx SCRIPTS "$GHREPOS/scripts/bin"
set -gx GHGISTS "$GHREPOS/gists"

# Go
set -gx CGO_ENABLED 0
set -gx GOPROXY direct
set -gx GOPATH "$HOME/.local/share/go"
set -gx GOBIN "$HOME/.local/share/go/bin/"

# Java
set -gx JAVA_HOME /usr/lib/jvm/default

fish_add_path "$SCRIPTS" "$GOBIN" "$HOME/.local/bin" "$JAVA_HOME/bin"

# CDPATH en Fish es una lista (array)
set -g CDPATH . $HOME "$REPOS/github.com" $GHREPOS $GHGISTS $DOTFILES

if status is-interactive
    function fish_greeting
    end
    fish_vi_key_bindings

    alias cat='bat'
    alias vi='$EDITOR'
    alias c='clear -x'
    alias clear='clear -x'
    alias todo='$EDITOR $HOME/.TODO.md'
    alias ls='eza --icons --group-directories-first -F'
    alias la='eza --icons --group-directories-first -F --all'
    alias ll='eza --icons --group-directories-first -F --all --long'
    alias tree='eza --tree --icons --group-directories-first -F --all'

    if type -q starship
        starship init fish | source
    end
    fzf --fish | source
    zoxide init fish --cmd cd | source
end
