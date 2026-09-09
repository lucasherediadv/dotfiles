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
fish/setup
sway/setup
```

Each tool's `setup` script creates `~/.config/<tool>/` and symlinks configuration files into it. **Edit files in this repo, not in `~/.config/` directly.**

## Tools

| Directory  | Tool       | Notes                                          |
| ---------- | ---------- | ---------------------------------------------- |
| `bash/`    | Bash       | Fallback shell, `.bashrc` and `.bash_profile`  |
| `fish/`    | Fish       | Primary shell, vi mode, starship prompt         |
| `nvim/`    | Neovim     | LazyVim + gruvbox-material                      |
| `vim/`     | Vim        | Minimal fallback                                |
| `tmux/`    | tmux       | Terminal multiplexer                            |
| `sway/`    | Sway       | Wayland WM, hostname-based configs              |
| `foot/`    | Foot       | Terminal emulator                               |
| `starship/`| Starship   | Cross-shell prompt                              |
| `git/`     | Git        | Git config                                      |
| `gh/`      | GitHub CLI | gh config                                       |

## Scripts

Utility scripts live in `scripts/` (no `.sh` extension). They are added to `$PATH` via `$SCRIPTS` (`scripts/newscript` scaffolds new ones).

Create a new script with:

```sh
newscript <name>
```

## Package lists

`packages/` contains hostname-specific `pacman` package lists. To restore packages on a machine:

```sh
sudo pacman -S --needed - < packages/<hostname>.txt
```

## Git workflow

[Conventional Commits](https://www.conventionalcommits.org/) with a dotfiles scope:

```
type(scope): subject

feat(nvim): add telescope extension
refactor(fish): clean up abbrs
chore(packages): update helium list
```

Branch naming: `type-scope/subject` (e.g. `refactor-nvim/cleanup-plugins`).
