# Agent Instructions

## Repository Overview

Personal `dotfiles` for Arch Linux + Sway (Wayland). Configuration-only repository; no build, test, or lint infrastructure.

## Setup

```bash
./setup                   # Install all (root + 6 components)
cd <component> && ./setup # Install one component
```

## Architecture

**Root files** (symlinked to `$HOME`): `.bashrc` `.bash_profile` `.inputrc` `.vimrc`

**XDG components** (symlinked to `$HOME/.config/<name>/`):

| Component | Files |
|-----------|-------|
| `foot/` | `foot.ini` |
| `gh/` | `config.yml` |
| `git/` | `config` |
| `sway/` | `config` |
| `tmux/` | `tmux.conf` |

**`packages/`** contains Arch Linux package lists (`laptop.txt`, `desktop.txt`). Install via:

```bash
pacman -S --needed - < packages/laptop.txt
```

**Component `setup` pattern:** `mkdir -p <target_dir> && ln -fs "$PWD/<file>" "<target_dir>/<file>"` — idempotent, safe to re-run. Loop is defined in `./setup`.

## Commits

- No AI co-authorship trailers
- Follow [Conventional Commits](https://www.conventionalcommits.org/): `type: description` (scope optional)
