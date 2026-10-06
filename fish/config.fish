set -g fish_greeting

set -gx PAGER less
set -gx LESSHISTFILE /dev/null
set -gx LESS "-R -i -F -X --mouse --wheel-lines=3"

set -gx MANROFFOPT -c
set -gx MANPAGER "sh -c 'col -bx | bat --theme-dark=gruvbox-dark -l man -p'"

set -gx FZF_DEFAULT_OPTS --reverse

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx BROWSER firefox

set -gx REPOS "$HOME/repos"
set -gx GITUSER lucasherediadv
set -gx GHREPOS "$REPOS/github.com/$GITUSER"

set -gx DOTFILES "$GHREPOS/dotfiles"
set -gx SCRIPTS "$DOTFILES/scripts"
set -gx NOTES "$GHREPOS/notes"

set -gx CDPATH ".:$HOME:$REPOS/github.com:$GHREPOS:$DOTFILES"

if status is-interactive
    fish_vi_key_bindings

    if type -q asciiquarium
        alias fishies asciiquarium
    end
    if type -q pstree
        alias pstree "pstree -UC age"
    end
    if type -q tree
        alias tree "tree --dirsfirst -a -C -I .git"
        alias lt "tree --dirsfirst -a -C -I .git -L 1"
    end
    alias todo "$EDITOR $HOME/TODO.md"
    if type -q bat
        alias cat "bat --theme-dark=gruvbox-dark"
    end

    if type -q eza
        alias ls "eza --icons --group-directories-first --classify=auto"
        alias la "eza --all --icons --group-directories-first --classify=auto"
        alias ll "eza --long --icons --group-directories-first --classify=auto"
        alias lla "eza --long --all --icons --group-directories-first --classify=auto"
    end

    abbr --add syu "sudo pacman -Syu --noconfirm"

    abbr --add 0 "cd $HOME/0"

    abbr --add reload "exec fish --login"

    abbr --add e exit
    abbr --add t tmux

    abbr --add c "clear -x"
    abbr --add clear "clear -x"

    abbr --add v "$EDITOR"
    abbr --add vi "$EDITOR"

    abbr -a .. "cd ./../"
    abbr -a ... "cd ./../../"
    abbr -a .... "cd ./../../../"

    abbr --add cp "cp --verbose"
    abbr --add ln "ln --verbose"
    abbr --add mv "mv --verbose"
    abbr --add rm "rm --verbose"
    abbr --add rmdir "rmdir --verbose"

    abbr --add ip "ip --color=auto"
    abbr --add diff "diff --color=auto"
    abbr --add grep "grep --color=auto"

    abbr --add free "free --mega --human"
    abbr --add df "df --human-readable"
    abbr --add du "du --human-readable"

    if type -q pass
        abbr --add pc "pass show --clip"
    end

    abbr --add g git
    if type -q lazygit
        abbr --add lg lazygit
    end
    abbr --add gp "git pull"
    abbr --add gd "git diff"
    abbr --add gps "git push"
    abbr --add gs "git status"
    abbr --add gaa "git add --all"
    abbr --add gds "git diff --staged"

    abbr --add repos "cd $REPOS"
    abbr --add ghrepos "cd $REPOS/github.com/"
    abbr --add myrepos "cd $GHREPOS"
    abbr --add scripts "cd $SCRIPTS"
    abbr --add dotfiles "cd $DOTFILES"

    abbr --add notes "cd $NOTES"
    abbr --add n "$EDITOR $NOTES"

    if type -q fzf
        fzf --fish | source
    end
    if type -q starship
        starship init fish | source
    end
end

fish_add_path --path "$SCRIPTS" "$HOME/.local/bin"
