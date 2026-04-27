# Agent Instructions

## General

- Automatically update this `AGENTS.md` file when new preferences, conventions, or context are established for this repo

## Repository Overview

This is a personal `dotfiles` repository managing shell configuration and environment setup across multiple tools and applications. The project uses a modular structure with a main setup script that coordinates installation of individual component configurations.

## Architecture

**Project Structure:**
- **Root scripts** (`.bashrc`, `.bash_profile`, `.vimrc`, `.inputrc`) - Core shell and editor configurations
- **Modular components** (subdirectories: `git/`, `tmux/`, `sway/`, `foot/`) - Tool-specific configurations with self-contained setup
- **Main entry point** - `./setup` (root script that orchestrates all component setups)

**Setup Pattern:**
Each major component (`git`, `tmux`, `sway`, `foot`) follows an identical pattern:
1. Has a `setup` executable script
2. Contains configuration files to be symlinked (e.g., `git/config` → `~/.config/git/config`)
3. The root `./setup` script loops through all components and calls their individual setup scripts

**Key Convention:**
All tool-specific configurations use `XDG Base Directory Specification` (`$HOME/.config/`) for file locations.

## Build, Test, and Lint Commands

**Install/Setup:**
```bash
./setup                  # Main entry point - installs all component configs
cd <component> && ./setup # Individual component setup (git, tmux, sway, or foot)
```

There is no build, test, or lint infrastructure in this project. It is a configuration management repository that uses shell scripts for installation.

## Key Conventions

**Bash Configuration:**
- `.bashrc` sets shell options via `shopt` and is sourced on every interactive shell
- `.bash_profile` is sourced on login shells (includes `TTY` detection for auto-starting Sway)
- Uses `starship` for prompt rendering (see `eval "$(starship init bash)"`)
- Custom `$CDPATH` defined for quick directory navigation to repos: `.`, `$HOME`, `$REPOS/github.com`, `$GHREPOS`, `$DOTFILES`
- `pathappend()` function de-duplicates and extends `$PATH` safely

**Repository Paths:**
- `$REPOS` → `$HOME/repos`
- `$GHREPOS` → `$REPOS/github.com/lucasherediadv`
- `$DOTFILES` → `$GHREPOS/dotfiles`
- `$SCRIPTS` → `$GHREPOS/scripts/bin`

**Important Environment Variables:**
- `PAGER=less`, `EDITOR=vim`, `VISUAL=vim`, `BROWSER=firefox`
- `GITUSER=lucasherediadv` (used by custom `clone()` function)

**Custom Functions:**
- `clone()` - Clones repos intelligently to organized directory structure using `gh repo clone` with sub-modules
- `pathappend()` - Safely appends directories to `$PATH` without duplicates

**File Linking Pattern:**
Setup scripts use symbolic links (e.g., `ln -fs "$PWD/config" "$HOME/.config/git/config"`). The `-f` flag allows re-running setup without errors.

## When Modifying Configurations

- **Adding new tool configurations:** Create a new subdirectory with a `setup` script and configuration files, then add it to the root `./setup` loop
- **Updating shell functions:** Export them with `export -f` if they need to be available in sub-shells
- **Symlink safety:** Use `ln -fs` so repeated setup runs don't fail

## Commits

- Never add `Co-authored-by: Copilot` or any Copilot trailer to commits
- Never add any AI co-authorship trailers to commit messages
