# AGENTS

Personal dotfiles repo. No build system, no CI/CD, no tests. Assumes Arch Linux.

## Structure

Flat layout: one directory per tool (`bash/`, `nvim/`, `tmux/`, `sway/`, `scripts/`, etc.).
Each tool directory has a `setup` script that creates `~/.config/<tool>/` and symlinks configurations into it.
The root `setup` script orchestrates all sub-setups.

Dotfiles are stored without the leading dot so they are visible by default (`bash/bashrc`, `bash/bash_profile`, `vim/vimrc`); the `setup` scripts add the dot when linking (`~/.bashrc`, `~/.bash_profile`, `~/.vimrc`).

**Do not edit files in `~/.config/` directly.** Edit the source file in this repo, then run `./setup` to re-link.

### Setup

Tool `setup` scripts resolve their own directory from `$0`, so they can be run from anywhere (`./setup`, `bash/setup`, `cd bash && ./setup`).

## Key commands

```sh
./setup          # symlink all configurations (runs from anywhere)
bash/setup       # individual tool setup
nvim/setup       # ...same pattern
```

## Environment

- Shell: Bash, both login (TTY1 starts Sway) and interactive. Keep it close to POSIX sh: no `shopt` glob extensions, short portable options in aliases
- Environment: exported variables and `$PATH` live only in `bash/profile` (POSIX, linked to `~/.profile`), loaded by `bash_profile` before Sway so the whole session inherits them. Interactive-only config (aliases, functions, history, `CDPATH`) lives in `bash/bashrc`
- Line editing: `readline/inputrc` (linked to `~/.inputrc`) holds vi mode for every readline program, otherwise kept at the defaults; do not use `bind` in `bashrc`
- Editor: Neovim (LazyVim, gruvbox), Vim. `vimrc` must load on minimal builds (e.g. vim-tiny): guard features with `has()`/`exists()`
- Tool configs must not duplicate `bash/profile`: `gh` takes editor, browser and pager from `$EDITOR`, `$BROWSER` and `$PAGER`
- Git: `gh` credential helper lives in `git/credential-gh`, linked by `git/setup` only when `gh` is installed
- Terminal: Foot / JetBrains Mono
- WM: Sway (Wayland)
- Prompt: `__ps1` in `bash/bashrc` (two lines: user@host:dir(branch), then $)
- Theme: Gruvbox, vi mode everywhere

## Scripts

Utility scripts in `scripts/` (no `.sh` extension). Scaffold with `scripts/newscript <name>`.

Prefer `#!/bin/sh` with POSIX commands and short options; use `#!/usr/bin/env bash` only when bash features are needed. Never hardcode interpreter paths (`/bin/bash`, `/usr/bin/perl`).

## LazyVim

Lean starter: `init.lua`, `lua/config/lazy.lua`, `lua/config/options.lua`, `lua/plugins/gruvbox.lua`. Extra plugins in `nvim/lua/plugins/`. `lazy-lock.json` and `lazyvim.json` are ignored.

## Git workflow

Conventional Commits with dotfiles scope: `type(scope): subject` (e.g. `feat(nvim):`, `refactor(bash):`). Subject lowercase, imperative mood. Prefer `chore`/`docs` over `feat` for housekeeping.

Commits are a single line: type, scope and subject are all required. No body, and no `Co-Authored-By` or any other AI agent attribution.

Commit directly to `main`; no feature branches.

Default branch: `main`. Uses `gh` CLI.
