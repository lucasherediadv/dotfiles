# If running from tty1 start sway
if [ -z "$WAYLAND_DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  if command -v sway >/dev/null 2>&1; then
    exec sway
  else
    echo "Sway is not installed. Continuing to shell."
  fi
fi

# Source ~/.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
