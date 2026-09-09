# AGENTS

Personal dotfiles repo. No build system, no CI/CD, no tests. Assumes Arch Linux (`pacman`).

## Structure

Flat layout: one directory per tool (`fish/`, `nvim/`, `tmux/`, `sway/`, `scripts/`, etc.).
Each tool directory has a `setup` script that creates `~/.config/<tool>/` and symlinks configurations into it.
The root `setup` script orchestrates all sub-setups and handles home-directory dotfiles (`.bashrc`, `.bash_profile`, `.vimrc`).

`packages/` holds hostname-specific `pacman` package lists, not tool configurations. Restore with `sudo pacman -S --needed - < <hostname>.txt`.

**Do not edit files in `~/.config/` directly.** Edit the source file in this repo, then run `./setup` to re-link.

### Setup

Tool `setup` scripts symlink using `$PWD` and must run from their own directory (`fish/setup` from inside `fish/`); running from the repo root creates dangling symlinks.

### Hostname-based configurations

Some directories select files by `/etc/hostname` (currently `sway/` and `packages/`). Pattern: place `<name>.<hostname>` files in the tool directory; the `setup` script symlinks based on hostname.

## Key commands

```sh
./setup          # symlink all configurations (must run from repo root)
fish/setup       # individual tool setup (run from repo root)
nvim/setup       # ...same pattern
```

## Environment

- Shell: Fish (primary), Bash (fallback)
- Editor: Neovim (LazyVim, gruvbox), Vim
- Terminal: Foot / JetBrains Mono
- WM: Sway (Wayland)
- Prompt: Starship
- Theme: Gruvbox, vi mode everywhere

## Scripts

Utility scripts in `scripts/` (no `.sh` extension). Scaffold with `scripts/newscript <name>`.

## LazyVim

Lean starter: `init.lua`, `lua/config/lazy.lua`, `lua/plugins/gruvbox-material.lua`. Extra plugins in `nvim/lua/plugins/`. `lazy-lock.json` and `lazyvim.json` are ignored.

## Git workflow

Conventional Commits with dotfiles scope: `type(scope): subject` (e.g. `feat(nvim):`, `refactor(fish):`). Subject lowercase, imperative mood. Prefer `chore:`/`docs:` over `feat:` for housekeeping.

Branch naming: `type-scope/subject` (e.g. `refactor-nvim/cleanup-plugins`).

Default branch: `main`. Uses `gh` CLI.
