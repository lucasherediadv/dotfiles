Lucas Heredia's dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

### Quick start

Install them with:
```console
$ chezmoi init lucasherediadv
```

Check what changes that chezmoi will make to your home directory by running:
```console
$ chezmoi diff
```

If you are happy with the changes that chezmoi will make then run:
```console
$ chezmoi apply --verbose
```

### Personal setup

To set up a new machine following my standard directory structure:
```console
$ chezmoi init --apply --source "$HOME/repos/github.com/lucasherediadv/dotfiles" lucasherediadv
```
