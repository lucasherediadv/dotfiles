set -g fish_greeting

# Editor
set -gx EDITOR nvim
set -gx VISUAL nvim

# Pager
set -gx PAGER less
set -gx LESSHISTFILE /dev/null

if status is-interactive
    fish_vi_key_bindings
    function fish_mode_prompt
    end

    abbr vi nvim
    abbr c clear -x
    abbr clear clear -x
    abbr ls ls -hF --color=auto --group-directories-first
    abbr la ls -hF --color=auto --group-directories-first --all
    abbr ll ls -hF --color=auto --group-directories-first -l --all
end
