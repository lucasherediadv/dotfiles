# AGENTS.md

Personal dotfiles repo. No build system, no CI/CD, no tests. Assumes Arch Linux (pacman).

## Structure

Flat layout: one directory per tool (`fish/`, `nvim/`, `tmux/`, `sway/`, `scripts/`, etc.).  
Each tool directory has a `setup` script that creates `~/.config/<tool>/` and symlinks configs into it.  
The root `setup` script orchestrates all sub-setups and handles home-dir dotfiles (`.bashrc`, `.bash_profile`, `.vimrc`).

`packages/` is an exception: it holds hostname-specific pacman package lists (`helium.txt`, `titanium.txt`), not tool configs. `packages/setup` runs `sudo pacman -S --needed`; `packages/save` snapshots installed packages.

**Do not edit files in `~/.config/` directly.** Edit the source file in this repo, then run `./setup` to re-link.

### Hostname-based configs

Some directories select files by `/etc/hostname`. Currently `sway/` (`config.helium`, `config.titanium`) and `packages/` (`helium.txt`, `titanium.txt`). When adding hostname-varying configs, follow this pattern: place `<name>.<hostname>` files in the tool directory and have the `setup` script symlink based on hostname.

## Key commands

```sh
./setup          # symlink all configs (must run from repo root)
```

Individual tool setup can be run standalone:
```sh
fish/setup       # symlinks fish config
nvim/setup       # symlinks neovim config
```

## Environment conventions

- Shell: Fish (primary), Bash (fallback)
- Editor: Neovim (LazyVim, gruvbox), Vim (standalone .vimrc)
- Terminal: Foot with JetBrains Mono font
- Window manager: Sway (Wayland)
- Prompt: Starship
- Theme: Gruvbox throughout
- Vi mode enabled everywhere (bash, tmux, neovim, sway)

## Repository layout for other repos

The repo assumes code lives at: `$REPOS/github.com/$GITUSER/<repo>`  
(e.g., `~/repos/github.com/lucasherediadv/some-project`)

## Scripts

Utility scripts in `/scripts/` (no `.sh` extension by convention).  
All are POSIX shell or bash. Key ones: `t` (tmux), `d` (docker), `branch`/`push` (git helpers), `extract` (archives).

## LazyVim (nvim/)

Standard LazyVim starter template. Custom additions: gruvbox theme, Java language support.  
Plugin lock file: `nvim/lazy-lock.json`.  
Formatting: StyLua (2-space indent, 120 columns).

## Git config

Uses `gh` CLI for credential management. Default branch: `main`.  
User: Lucas Agustin Heredia (`lucasherediadv@gmail.com`).
