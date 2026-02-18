set -g fish_greeting

set -gx PAGER less
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx REPOS $HOME/repos
set -gx GITUSER lucasherediadv
set -gx GHREPOS $REPOS/github.com/$GITUSER

set -gx CDPATH .:$GHREPOS:$REPOS/github.com:$HOME

if status is-interactive
  fish_vi_key_bindings
  function fish_mode_prompt
  end

  abbr vi nvim
  abbr df df -h
  abbr du du -h
  abbr c clear -x
  abbr clear clear -x
  abbr free free -h -m
  abbr ip ip --color=auto
  abbr pstree pstree -UC age
  abbr diff diff --color=auto
  abbr grep grep --color=auto
  abbr todo $EDITOR $HOME/.todo.md
  abbr ls ls -F --group-directories-first
  abbr tree tree -a -C -I .git --gitignore
  abbr psc ps xawf -eo pid,user,cgroup,args
  abbr la ls -F --group-directories-first -a
  abbr ll ls -F --group-directories-first -a -l
end
