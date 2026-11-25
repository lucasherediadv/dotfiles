function zo --description 'Pick a subdirectory with fzf and cd into it'
    set -l dir (find . -type d -not -path '*/.*' | fzf --height 40% --border --prompt 'Select a directory: ')
    or return
    cd -- $dir
end
