set -g fish_greeting

set -gx PAGER less
set -gx LESSHISTFILE /dev/null/
set -gx LESS "-R -i -F -X --mouse --wheel-lines=3"

set -gx MANROFFOPT -c
set -gx MANPAGER "sh -c 'col -bx | bat --theme-dark=gruvbox-dark -l man -p'"

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx REPOS "$HOME/repos"
set -gx GITUSER lucasherediadv
set -gx GHREPOS "$REPOS/github.com/$GITUSER"

set -gx DOTFILES "$GHREPOS/dotfiles"
set -gx SCRIPTS "$DOTFILES/scripts/"

set -gx CDPATH ".:$HOME:$REPOS/github.com:$GHREPOS:$DOTFILES"

if status is-interactive
    fish_vi_key_bindings

    alias fishies asciiquarium
    alias pstree "pstree -UC age"
    alias tree "tree --dirsfirst -a -C -I .git"
    alias todo "$EDITOR $HOME/TODO.md"
    alias cat "bat --theme-dark=gruvbox-dark"

    alias ls "eza --icons --group-directories-first --classify=auto"
    alias la "eza --all --icons --group-directories-first --classify=auto"
    alias ll "eza --long --icons --group-directories-first --classify=auto"
    alias lla "eza --long --all --icons --group-directories-first --classify=auto"

    abbr --add c "clear -x"
    abbr --add clear "clear -x"

    abbr --add v "$EDITOR"
    abbr --add vi "$EDITOR"

    abbr --add cp "cp --interactive"
    abbr --add mv "mv --interactive"
    abbr --add ln "ln --interactive"
    abbr --add mv "mv --parents --verbose"
    abbr --add rm "rm --interactive=always"

    abbr --add ip "ip --color=auto"
    abbr --add diff "diff --color=auto"
    abbr --add grep "grep --color=auto"
    abbr --add diff "diff --color=auto"

    abbr --add free "free --mega --human"
    abbr --add df "df --human-readable"
    abbr --add du "du --human-readable"

    abbr --add lg lazygit
    abbr --add gp "git pull"
    abbr --add gs "git status"

    abbr --add repos "cd $REPOS"
    abbr --add ghrepos "cd $GHREPOS"
    abbr --add scripts "cd $SCRIPTS"
    abbr --add dotfiles "cd $DOTFILES"

    fzf --fish | source
    starship init fish | source
end

fish_add_path $SCRIPTS
