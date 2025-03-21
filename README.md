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

## Fish

[fish shell](https://fishshell.com/) - The user-friendly command line shell. [source code](https://github.com/fish-shell/fish-shell)

plugins:

- [starship](https://github.com/starship/starship) - The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- [fisher](https://github.com/jorgebucaran/fisher) - A plugin manager for Fish.
- [fzf.fish](https://github.com/patrickF1/fzf.fish) - Fzf plugin for Fish.

## CLI Tools

### Development

- [delta](https://github.com/dandavison/delta) - A syntax-highlighting pager for git, diff, grep, and blame output.
- [lazygit](https://github.com/jesseduffield/lazygit) - Simple TUI for git commands.
- [neovim](https://github.com/neovim/neovim) - Vim-fork focused on extensibility and usability.

### Utilities

- [btop](https://github.com/aristocratos/btop) - A monitor of resources.
- [fastfetch](https://github.com/fastfetch-cli/fastfetch) - System information tool.
- [glow](https://github.com/charmbracelet/glow) - Styled markdown rendering.
- [tmux](https://github.com/tmux/tmux) - A terminal multiplexer.

### Command Line Learning

- [The Fuck](https://github.com/nvbn/thefuck) - Magnificent app which corrects your previous console command.
- [tldr](https://github.com/tldr-pages/tldr) - Simplified and community-driven man pages.

### Files and Directories

- [eza](https://github.com/eza-community/eza) - A modern alternative to ls.
- [fzf](https://github.com/junegunn/fzf) - A command-line fuzzy finder.
- [fd](https://github.com/sharkdp/fd) - A simple, fast and user-friendly alternative to `find`.
- [ripgrep](https://github.com/BurntSushi/ripgrep) - A line-oriented search tool that recursively searches your current directory for a regex pattern. Better `grep`
- [yazi](https://github.com/sxyazi/yazi) - Blazing fast terminal file manager written in Rust, based on async I/O.
  - [max-preview](https://github.com/yazi-rs/plugins/tree/main/max-preview.yazi)
  - [glow.yazi](https://github.com/Reledia/glow.yazi) - Preview markdown files.
  - [bookmarks.yazi](https://github.com/dedukun/bookmarks.yazi)

### macOS

- [SketchyBar](https://github.com/FelixKratz/SketchyBar) - A highly customizable macOS status bar replacement.
- [skhd](https://github.com/koekeishiya/skhd) - Simple hotkey daemon for macOS.
- [yabai](https://github.com/koekeishiya/yabai) - A tiling window manager for macOS based on binary space partitioning.

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

### fzf.fish keybindings

|       Key        | Command           |
| :--------------: | ----------------- |
|    `ctrl + f`    | Search Directory  |
|    `ctrl + r`    | Search History    |
| `ctrl + alt + l` | Search Git Log    |
| `ctrl + alt + s` | Search Git Status |
| `ctrl + alt + p` | Search Processes  |
| `ctrl + alt + v` | Search Variables  |

### Yazi keybindings

|     Key     | Action                                         |
| :---------: | ---------------------------------------------- |
|     `.`     | Toggle the visibility of hidden files          |
|     `z`     | Jump to a directory using zoxide               |
|     `Z`     | Jump to a directory or reveal a file using fzf |
|     `s`     | Search files by name using `fd`                |
|     `S`     | Search files by content using `ripgrep`        |
|     `K`     | Seek up 5 units in the preview                 |
|     `J`     | Seek down 5 units in the preview               |
|     `T`     | Maximize or restore preview                    |
|     `t`     | Create a new tab with CWD                      |
|  `[` / `]`  | Switch to the previous/next tab                |
|  `{` / `}`  | Swap current tab with previous/next tab        |
| `alt + j/k` | Navigation in the parent directory             |
|     `m`     | Save current position as a bookmark            |
|     `'`     | Jump to a bookmark                             |
|  `b`, `d`   | Delete a bookmark                              |
|  `b`, `D`   | Delete all bookmarks                           |

