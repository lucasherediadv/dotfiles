Hostname-specific `pacman` package lists.

## Restore packages

```sh
sudo pacman -S --needed - < helium.txt
```

Replace `helium.txt` with the appropriate hostname file.

## Save current packages

```sh
pacman -Qqe > "$(hostname).txt"
```
