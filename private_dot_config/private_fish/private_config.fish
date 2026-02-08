set -g fish_greeting

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx PAGER less
set -gx LESSHISTFILE /dev/null

if status is-interactive
  fish_vi_key_bindings
  function fish_mode_prompt
  end

  abbr vi nvim
  abbr c clear -x
  abbr clear clear -x
  abbr ls ls -Fh --color --group-directories-first
  abbr la ls -aFh --color --group-directories-first
  abbr ll ls -aFhl --color --group-directories-first
end
