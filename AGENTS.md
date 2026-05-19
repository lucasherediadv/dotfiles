# Agent Instructions

## Repository Overview

Personal `dotfiles` repository managing shell configuration and environment setup on Arch Linux with `Sway` (`Wayland`). Uses a modular structure: a root `./setup` script `symlinks` root-level configurations, then iterates through component sub directories calling each one's `setup`.

## Architecture

**Project Structure:**
- **Root configuration files** — `.bashrc`, `.bash_profile`, `.vimrc`, `.inputrc` (system linked directly to `$HOME`)
- **Component sub directories** — `fish/`, `foot/`, `gh/`, `git/`, `nvim/`, `starship/`, `sway/`, `tmux/` — each has a `setup` script that system links configurations into `$HOME/.config/`
- **Main entry point** — `./setup` (runs root `symlinks`, then loops `for i in fish foot gh git nvim starship sway tmux`)

**Setup Pattern:**
Each component `setup` script:
1. Creates the target directory with `mkdir -p`
2. System links with `ln -fs` (idempotent, safe to re-run)

For multi-file components (`nvim/`), the setup script iterates through tracked files/dirs, removes any existing target with `rm -rf`, then creates a symlink with `ln -s` (since `ln -fs` cannot replace an existing real directory).

**Key Convention:**
All tool-specific configurations follow the `XDG Base Directory` spec (`$HOME/.config/`).

## Commands

```bash
./setup                   # Install all configurations (root + all components)
cd <component> && ./setup # Install one component only (e.g. `cd fish && ./setup`)
```

No build, test, or lint infrastructure. This is a configurations-only repository.

## Key Conventions

**Shell (`.bash_profile`):**
- Auto-starts Sway when logging in on `VT1` (`TTY1`), gated by `WAYLAND_DISPLAY` and `XDG_VTNR`
- Sources `.bashrc` after the Sway check

**Shell (`.bashrc`):**
- Early-exits for non-interactive shells (`case $- in *i*)`)
- Editor is `nvim`
- Terminal pager uses `bat` (`alias cat='bat'`)
- `ls` aliased to `eza --icons --group-directories-first -F`
- Vi keybindings in `readline` (`set -o vi`)
- Large history: `HISTSIZE=500000`, `HISTFILESIZE=100000`, `PROMPT_COMMAND='history -a'`
- `alias vi='$EDITOR'`, `alias todo='$EDITOR $HOME/.TODO.md'`, `alias clear='clear -x'`
- `GITUSER=lucasherediadv` hard coded; `clone()` uses it when cloning a bare repository name
- Sources optional personal configurations if present: `~/.bash_personal`, `~/.bash_private`, `~/.bash_work`
- `starship` prompt initialized conditionally (only if binary exists)

**Shell (fish):**
- Vi key bindings via `fish_vi_key_bindings`
- `zoxide init` replaces `cd` with a fuzzy directory jumper
- `fzf --fish` integration sourced in interactive mode
- Extra aliases not in bash: `c` (`clear -x`), `la` (`eza --all`), `ll` (`eza --all --long`), `tree` (`eza --tree --all`)
- `starship` prompt initialized conditionally
- `set -g CDPATH` uses Fish list syntax (not `$CDPATH` environment variable)
- `tmux` sets `default-shell /usr/bin/fish` (`tmux` depends on fish)

**`.inputrc`:**
- Vi keybindings in `readline` (`set editing-mode vi`)
- Bracketed paste enabled (`set enable-bracketed-paste on`)
- Case-insensitive tab completion (`set completion-ignore-case on`)
- Show all matches on first tab (`set show-all-if-ambiguous on`)

**Path variables:**
- `$REPOS` → `$HOME/repos`
- `$GHREPOS` → `$REPOS/github.com/$GITUSER`
- `$DOTFILES` → `$GHREPOS/dotfiles`
- `$SCRIPTS` → `$GHREPOS/scripts/bin`
- `$GHGISTS` → `$GHREPOS/gists`
- `$CDPATH` includes `.:$HOME:$REPOS/github.com:$GHREPOS:$GHGISTS:$DOTFILES`

**Notable environment:**
- `PAGER=less`, `EDITOR=nvim`, `VISUAL=nvim`, `BROWSER=firefox`
- `BAT_THEME=gruvbox-dark`
- Go: `CGO_ENABLED=0`, `GOPROXY=direct`, `GOPATH=$HOME/.local/share/go`
- Java: `JAVA_HOME=/usr/lib/jvm/default`

**Custom functions (exported):**
- `clone()` — clones repository via `gh repo clone` into the `$REPOS/github.com/<user>/<repo>` structure, with submodule support
- `pathappend()` — appends directories to `$PATH` without duplicates

**vim (`.vimrc`):**
- `expandtab`, 2-space indent, `smartindent`
- No line numbers, no status line, no swap/backup files
- Dark background, true color
- Trailing white space highlighted as visual error
- Spell check auto-enabled for `*.txt`, `*.md`, `*.adoc`

**tmux:**
- Prefix: `C-b` (default), no alternate prefix
- Status bar on top, yellow accent theme
- Right status: pomodoro timer, mode indicators (COPY/PREFIX/ZOOM), hostname
- Vi-style pane navigation (`h/j/k/l`) and resize (`C-h/j/k/l`)
- TPM with `tmux-resurrect` + `tmux-continuum` for session persistence
- `set-clipboard on` + `focus-events` for vim clipboard sync (Wayland/foot)
- Panes/windows killed without confirmation (`x`, `&`)
- Copy mode Enter saves selection to `/tmp/buf`

**nvim:**
- LazyVim-based distribution with lazy.nvim plugin manager
- Gruvbox theme
- Custom config split into `lua/config/{lazy,keymaps,options,autocmds}.lua`
- Plugin overrides in `lua/plugins/gruvbox.lua`
- `lazy-lock.json` tracked for reproducible plugin versions

## When Modifying Configurations

- **Adding a new component:** Create a sub directory with a `setup` script (use `mkdir -p` + `ln -fs` pattern) and add its name to the `for` loop in `./setup`
- **Updating shell functions:** Export with `export -f`
- **System link safety:** Always use `ln -fs`

## Commits

- Follow [Conventional Commits](https://www.conventionalcommits.org/) format: `type: description` (e.g. `feat:`, `fix:`, `style:`, `refactor:`, `docs:`). Scope is optional.
- Never add any AI co-authorship trailers to commit messages
