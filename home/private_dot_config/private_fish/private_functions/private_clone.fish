function clone --description 'Clone and organize GitHub repositories into a directory structure'
  set -l repo $argv[1]
  set -l user ""

  if test -z "$repo"
    echo "Usage: clone <user/repo> or <github_url>"
    return 1
  end

  set repo (string replace -r '^https://github.com/' '' $repo)
  set repo (string replace -r '^git@github.com:' '' $repo)
  set repo (string replace -r '\.git$' '' $repo)

  if string match -q "*/*" $repo
    set user (string split -m 1 / $repo)[1]
  else
    if set -q GITUSER
      set user $GITUSER
    else
      set user $USER
    end
  end

  set -l name (string split / $repo)[-1]

  set -l base_repos (set -q REPOS; and echo $REPOS; or echo "$HOME/repos")
  set -l user_dir "$base_repos/github.com/$user"
  set -l target_path "$user_dir/$name"

  if test -d "$target_path"
    echo "Repository already exists locally. Jumping to directory..."
    cd "$target_path"
  else
    mkdir -p "$user_dir"
    cd "$user_dir"; or return 1

    echo "Cloning $user/$name using GitHub CLI..."
    gh repo clone "$user/$name" -- --recurse-submodule

    if test -d "$name"
      cd "$name"
    end
  end
end
