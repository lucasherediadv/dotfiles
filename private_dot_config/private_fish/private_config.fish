set -g fish_greeting

set -gx PAGER less
set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx REPOS "$HOME/repos"
set -gx GITUSER "lucasherediadv"
set -gx GHREPOS "$REPOS/github.com/$GITUSER"

set -gx CDPATH ".:$GHREPOS:$REPOS/github.com:$HOME"

if status is-interactive
  fish_vi_key_bindings
  function fish_mode_prompt
  end

  abbr vi nvim
  abbr c clear -x
  abbr clear clear -x
  abbr todo $EDITOR $HOME/.todo.md
  abbr cat bat --theme-dark=gruvbox-dark
  abbr ls eza -F --icons --group-directories-first
  abbr la eza -F --icons --group-directories-first -a
  abbr ll eza -F --icons --group-directories-first -a -l

  starship init fish | source
end
