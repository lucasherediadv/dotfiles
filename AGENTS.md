# AGENTS

Personal dotfiles repo. No build system, no CI/CD, no tests. Assumes Arch Linux.

## Structure

Flat layout: one directory per tool (`fish/`, `nvim/`, `tmux/`, `sway/`, `scripts/`, etc.).
Each tool directory has a `setup` script that creates `~/.config/<tool>/` and symlinks configurations into it.
The root `setup` script orchestrates all sub-setups.

Dotfiles are stored without the leading dot so they are visible by default (`bash/bashrc`, `bash/bash_profile`, `vim/vimrc`); the `setup` scripts add the dot when linking (`~/.bashrc`, `~/.bash_profile`, `~/.vimrc`).

**Do not edit files in `~/.config/` directly.** Edit the source file in this repo, then run `./setup` to re-link.

### Setup

Tool `setup` scripts symlink using `$PWD` and must run from their own directory (`fish/setup` from inside `fish/`); running from the repo root creates dangling symlinks.

## Key commands

```sh
./setup          # symlink all configurations (must run from repo root)
fish/setup       # individual tool setup (run from repo root)
nvim/setup       # ...same pattern
```

## Environment

- Shell: Bash is the login shell (TTY1 starts Sway), Fish is the interactive shell (foot, tmux, herdr)
- Environment: exported variables and `$PATH` live only in `bash/profile` (POSIX, linked to `~/.profile`), loaded by `bash_profile` before Sway so the whole session inherits them. `config.fish` only imports it as a fallback; keep shell-specific config (aliases, abbrs, `CDPATH`) in each shell
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

Conventional Commits with dotfiles scope: `type(scope): subject` (e.g. `feat(nvim):`, `refactor(fish):`). Subject lowercase, imperative mood. Prefer `chore`/`docs` over `feat` for housekeeping.

Commits are a single line: type, scope and subject are all required. No body, and no `Co-Authored-By` or any other AI agent attribution.

Branch naming: `type-scope/subject` (e.g. `refactor-nvim/cleanup-plugins`).

Default branch: `main`. Uses `gh` CLI.
