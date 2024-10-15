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

## Packages

- [GitHub - aristocratos/btop: A monitor of resources](https://github.com/aristocratos/btop)
- [GitHub - dandavison/delta: A syntax-highlighting pager for git, diff, grep, and blame output](https://github.com/dandavison/delta)
- [GitHub - eza-community/eza: A modern alternative to ls](https://github.com/eza-community/eza)
- [GitHub - fastfetch-cli/fastfetch: An actively maintained, feature-rich and performance oriented, neofetch like system information tool.](https://github.com/fastfetch-cli/fastfetch)
- [GitHub - fish-shell/fish-shell: The user-friendly command line shell.](https://github.com/fish-shell/fish-shell)
- [GitHub - junegunn/fzf: :cherry\_blossom: A command-line fuzzy finder](https://github.com/junegunn/fzf)
- [GitHub - jesseduffield/lazygit: simple terminal UI for git commands](https://github.com/jesseduffield/lazygit)
- [GitHub - neovim/neovim: Vim-fork focused on extensibility and usability](https://github.com/neovim/neovim)
- [GitHub - FelixKratz/SketchyBar: A highly customizable macOS status bar replacement](https://github.com/FelixKratz/SketchyBar)
- [GitHub - koekeishiya/skhd: Simple hotkey daemon for macOS](https://github.com/koekeishiya/skhd)
- [GitHub - starship/starship: ☄🌌️ The minimal, blazing-fast, and infinitely customizable prompt for any shell!](https://github.com/starship/starship)
- [GitHub - nvbn/thefuck: Magnificent app which corrects your previous console command.](https://github.com/nvbn/thefuck)
- [GitHub - tldr-pages/tldr: 📚 Collaborative cheatsheets for console commands](https://github.com/tldr-pages/tldr)
- [GitHub - tmux/tmux: tmux source code](https://github.com/tmux/tmux)
- [GitHub - koekeishiya/yabai: A tiling window manager for macOS based on binary space partitioning](https://github.com/koekeishiya/yabai)
- [GitHub - sxyazi/yazi: 💥 Blazing fast terminal file manager written in Rust, based on async I/O.](https://github.com/sxyazi/yazi)

## Cheatsheet

### yabai/skhd keybindinga`hyper` key: `tab`

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

