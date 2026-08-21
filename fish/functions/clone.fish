function clone
    set -l repo $argv[1]
    set -l user ""

    set repo (string replace -r '^https://github.com/' '' -- $repo)
    set repo (string replace -r '^git@github.com:' '' -- $repo)

    if string match -q "*/*" -- $repo
        set user (string split -m 1 '/' -- $repo)[1]
    else
        set user $GITUSER
        test -z "$user"; and set user $USER
    end

    set -l name (string split '/' -- $repo)[-1]
    set -l userd "$REPOS/github.com/$user"
    set -l path "$userd/$name"

    if test -d "$path"
        cd "$path"
        return
    end

    mkdir -p "$userd"
    cd "$userd"
    echo gh repo clone "$user/$name" -- --recurse-submodule
    gh repo clone "$user/$name" -- --recurse-submodule
    cd "$name"
end
