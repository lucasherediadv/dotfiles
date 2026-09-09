#!/bin/bash
# shellcheck disable=SC1090

# Autostart Sway on TTY1 if installed and no display server is running
if [ -z "$WAYLAND_DISPLAY" ] &&
  [ -z "$DISPLAY" ] &&
  [ "${XDG_VTNR:-0}" -eq 1 ] &&
  command -v sway >/dev/null 2>&1; then

  export XDG_SESSION_TYPE=wayland
  exec sway
fi

# Source ~/.bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
