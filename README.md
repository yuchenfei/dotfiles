## Overview

My dotfiles, managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Chezmoi

On a new machine:

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply yuchenfei
```

Updating dotfiles on any machine is a single command:

```sh
chezmoi update
```

## Cheatsheet

### yabai/skhd keybindings

`hyper` key: `tab`

|              Key               | Description                            |
| :----------------------------: | -------------------------------------- |
|     `ctrl + alt + cmd - r`     | Restart yabai and skhd service         |
|        `ctrl + alt - s`        | [S]tack mode                           |
|        `ctrl + alt - d`        | Tiling mode, [D]efault                 |
|        `ctrl + alt - f`        | [F]loat mode                           |
|         `hyper - c/x`          | Create/Delete space                    |
|        `hyper - [1-6]`         | Go to space #[1-6]                     |
|       `ctrl + alt - x/y`       | Mirror space by x/y-axis               |
|       `ctrl + alt - e/r`       | Rotate space anti-/clockwise           |
|        `ctrl + alt - b`        | Balance space                          |
|        `ctrl + alt - g`        | Toggle gaps                            |
|       `hyper - h/j/k/l`        | Focus window                           |
|         `heyper - n/p`         | [Stack mode] Next/Prev window          |
|     `ctrl + alt - h/j/k/l`     | Move focused window left/down/up/right |
|      `ctrl + alt - [1-6]`      | Move focused window to space #[1-6]    |
|       `ctrl + alt - n/p`       | Move focused window to next/prev space |
|        `ctrl + alt - v`        | Toggle split orientation               |
|      `ctrl + alt - space`      | Toggle float window                    |
|     `ctrl + alt - return`      | Toggle fullscreen window               |
| `ctrl + alt + shift - h/j/k/l` | Resize window                          |
|   `ctrl + alt + cmd - space`   | Toggle sketchybar                      |

### Tmux keybindings

`<prefix>` key: `ctrl + space`

|           Key           | Description                                                |
| :---------------------: | ---------------------------------------------------------- |
|      `<prefix> r`       | Reload config                                              |
|    `<prefix> space`     | Toggle between the current and previous window             |
| `<prefix> ctrl + space` | Toggle between the current and the previous session        |
|      `<prefix> \`       | Horizontal split current window                            |
|      `<prefix> \|`      | Horizontal split current window, put new one to the left   |
|      `<prefix> -`       | Vertical split current window                              |
|      `<prefix> _`       | Vertical split current window, put new one to the top      |
|   `<prefix> h/j/k/l`    | Pane navigation                                            |
|   `<prefix> H/J/K/L`    | Pane resizing                                              |
|     `<prefix> g/G`      | Current pane join to selected window (horizontal/vertical) |
|     `<prefix> </>`      | Move current window to left/right                          |
|     ``<prefix> ` ``     | Jump to a marked pane (C-m mark pane)                      |
|    `<prefix> enter`     | Entry copy mode                                            |
|     `<copy-mode>v`      | Begin selection                                            |
|  `<copy-mode>ctrl + v`  | Toggle rectangle selection                                 |
|     `<copy-mode>y`      | Copy selected text                                         |
|    `<copy-mode>H/L`     | Start/End of line                                          |
|      `<prefix> b`       | List paste buffers                                         |
|   `<prefix> ctrl + p`   | Paste from top paste buffer                                |
|      `<prefix> P`       | Choose which buffer to paste from                          |

