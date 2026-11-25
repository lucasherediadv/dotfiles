set -g fish_greeting

# The environment comes from ~/.profile (bash login shell). If fish was
# started without it, import the variables that file exports.
if not set -q DOTFILES; and test -f $HOME/.profile
    for line in (sh -c '. "$HOME/.profile" >/dev/null 2>&1; env')
        set -l kv (string split --max 1 = -- $line)
        string match -qr '^(PWD|SHLVL|_)$' -- $kv[1]; and continue
        test (count $kv) -eq 2; or continue
        test "$$kv[1]" = "$kv[2]"; or set -gx $kv[1] $kv[2]
    end
end

# Not exported, so child scripts calling `cd` are not affected
set -gu CDPATH . $HOME $REPOS/github.com $GHREPOS $DOTFILES

if status is-interactive
    fish_vi_key_bindings

    ### Aliases ###

    alias todo "$EDITOR $HOME/TODO.md"

    if type -q asciiquarium
        alias fishies asciiquarium
    end
    if type -q pstree
        alias pstree "pstree -UC age"
    end
    if type -q bat
        alias cat "bat --theme-dark=gruvbox-dark"
    end
    if type -q tree
        alias lt "tree --dirsfirst -a -C -I .git -L 1"
    end
    if type -q eza
        set -l eza eza --icons --group-directories-first --classify=auto
        alias l "$eza"
        alias ls "$eza"
        alias la "$eza --all"
        alias ll "$eza --long"
        alias lla "$eza --long --all"
        alias tree "$eza --tree"
    else if type -q tree
        alias tree "tree --dirsfirst -a -C -I .git"
    end

    ### Abbreviations ###

    abbr --add reload "exec fish --login"
    abbr --add syu "sudo pacman -Syu --noconfirm"
    abbr --add e exit
    abbr --add t tmux
    abbr --add h herdr
    abbr --add c "clear -x"
    abbr --add clear "clear -x"
    abbr --add v "$EDITOR"
    abbr --add vi "$EDITOR"
    abbr --add cc claude
    abbr --add ccc "claude --continue"
    if type -q pass
        abbr --add pc "pass show --clip"
    end

    # Coreutils
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

    # Navigation
    abbr --add .. "cd ./../"
    abbr --add ... "cd ./../../"
    abbr --add .... "cd ./../../../"
    abbr --add 0 "cd $HOME/0"
    abbr --add repos "cd $REPOS"
    abbr --add ghrepos "cd $REPOS/github.com/"
    abbr --add myrepos "cd $GHREPOS"
    abbr --add scripts "cd $SCRIPTS"
    abbr --add dotfiles "cd $DOTFILES"
    abbr --add notes "cd $NOTES"
    abbr --add n "$EDITOR $NOTES"

    # Git
    abbr --add g git
    abbr --add gp "git pull"
    abbr --add gd "git diff"
    abbr --add gps "git push"
    abbr --add gs "git status"
    abbr --add gaa "git add --all"
    abbr --add gds "git diff --staged"
    if type -q lazygit
        abbr --add lg lazygit
    end

    # Integrations
    if type -q fzf
        fzf --fish | source
    end
    if type -q zoxide
        zoxide init --cmd cd fish | source
    end
    if type -q starship
        starship init fish | source
    end
end

for local_config in $HOME/.fish_personal.fish $HOME/.fish_private.fish $HOME/.fish_work.fish
    test -f $local_config; and source $local_config
end
