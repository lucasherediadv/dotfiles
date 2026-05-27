if status is-interactive
    function fish_greeting
    end
    fish_vi_key_bindings

    alias vi='$EDITOR'
    alias clear='clear -x'
    alias ls='eza --icons --group-directories-first -F'

    if type -q starship
        starship init fish | source
    end
end
