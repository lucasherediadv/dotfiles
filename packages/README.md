Hostname-specific `pacman` package lists.

## Restore packages

```sh
sudo pacman -S --needed - < hostname.txt
```

Replace `hostname.txt` with the appropriate hostname file.

## Save current packages

```sh
pacman -Qqe > "$(hostname).txt"
```
