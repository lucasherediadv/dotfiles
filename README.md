# Dotfiles

Personal Arch Linux dotfiles. Symlink-based setup with per-tool install scripts.

## Setup

```sh
git clone https://github.com/lucasherediadv/dotfiles.git ~/repos/github.com/lucasherediadv/dotfiles
cd ~/repos/github.com/lucasherediadv/dotfiles
./setup
```

Individual tools can be set up separately:

```sh
nvim/setup
bash/setup
sway/setup
```

Each tool's `setup` script creates `~/.config/<tool>/` and symlinks configuration files into it. **Edit files in this repo, not in `~/.config/` directly.**

Dotfiles are stored without the leading dot (e.g. `bash/bashrc`) so they are not hidden; `setup` links them with the dot (`~/.bashrc`).

## Tools

| Directory  | Tool       | Notes                                          |
| ---------- | ---------- | ---------------------------------------------- |
| `bash/`    | Bash       | Login and interactive shell, env in `profile`  |
| `readline/`| Readline   | `~/.inputrc`: vi mode and completion           |
| `nvim/`    | Neovim     | LazyVim + gruvbox                               |
| `vim/`     | Vim        | Minimal fallback                                |
| `tmux/`    | tmux       | Terminal multiplexer                            |
| `sway/`    | Sway       | Wayland WM                                      |
| `waybar/`  | Waybar     | Status bar for Sway                             |
| `foot/`    | Foot       | Terminal emulator                               |
| `git/`     | Git        | Git config                                      |
| `gh/`      | GitHub CLI | gh config                                       |

## Scripts

Utility scripts live in `scripts/` (no `.sh` extension). They are added to `$PATH` via `$SCRIPTS` (`scripts/newscript` scaffolds new ones).

Create a new script with:

```sh
newscript <name>
```

## Git workflow

[Conventional Commits](https://www.conventionalcommits.org/) with a dotfiles scope:

```
type(scope): subject

feat(nvim): add telescope extension
refactor(bash): clean up aliases
chore(waybar): tweak bar colors
```

Commit directly to `main`; no feature branches.
