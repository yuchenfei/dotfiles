# Plugin configuration

Files in `plugin/` are named `<category>-<plugin>.lua`, following functional
categories: `colorscheme`, `ui`, `editor`, `coding`, `lsp`, `treesitter`, `dap`,
`ai`, and `util`. Language-specific plugins share one `lang-<language>.lua`
file per language, such as `lang-lua.lua`, `lang-markdown.lua`, and
`lang-rust.lua`.

Snacks lives in `lua/config/snacks.lua` and is explicitly initialized by
`init.lua` before runtime plugins, which depend on its shared APIs. Neovim
automatically sources the remaining `plugin/` files; no numeric prefixes or
explicit import list are needed for them.

## Plugin management

[pack-ui.nvim](https://github.com/jtprogru/pack-ui.nvim) provides a floating UI
for `vim.pack` in both full and lite profiles. It loads on the first management
command or shortcut; startup only registers the commands and mappings.
Automatic checks and updates are disabled.

| Key | Command | Action |
| --- | --- | --- |
| `<leader>ps` | `:PackStatus` | Show plugin status without accessing the network |
| `<leader>pu` | `:PackUpdate` | Check updates and open the selection UI |
| `<leader>pU` | `:PackUpdateAll` | Check and apply all available updates |

Inside the window, use `<Space>` / `<Tab>` to mark plugins, `u` to update marked
plugins (or the current row), `U` to update all, `r` to check updates,
`<CR>` / `K` to view changes, and `q` / `<Esc>` to close. Applying updates from
this UI bypasses the native `vim.pack` confirmation buffer. Restart Neovim to
load the updated plugin code.

## AI CLI integration

[Sidekick](https://github.com/folke/sidekick.nvim) loads on the first AI shortcut
or `:Sidekick` command in the full profile. It uses a right-hand terminal split
with file watching enabled. Copilot NES and tmux/Zellij persistence are disabled.
The existing OpenCode integration remains available under `<leader>o`.

| Key | Action |
| --- | --- |
| `<leader>ac` | Toggle Codex CLI |
| `<leader>ag` | Toggle Antigravity CLI (`agy`) |
| `<leader>aa` | Toggle the selected AI CLI |
| `<leader>as` | Select an installed AI CLI |
| `<leader>at` | Send the selection or current location |
| `<leader>af` | Send the current file reference |
| `<leader>ap` | Choose a prompt, such as explain, fix, or review |
| `<leader>ad` | Detach the CLI session |

Install and authenticate `codex` and `agy` separately before using them. Sidekick
uses their existing login sessions. `agy` is a custom tool launching its standard
interactive TUI; if it is absent from PATH, the config checks
`/opt/homebrew/bin/agy`. Save files before sending references so the CLI reads
the latest content. Context and prompts are inserted for review; press Enter in
the CLI to submit. In the CLI terminal, `<C-.>` hides the window and `<C-q>`
enters normal mode.

## Plugin discovery

- [awesome-neovim](https://github.com/rockerBOO/awesome-neovim): browse curated
  plugins by category when looking for alternatives or new capabilities.
- [Dotfyle](https://dotfyle.com/): discover plugins and community configurations.
  Use [Top](https://dotfyle.com/neovim/plugins/top) to see adoption across tracked
  configurations, and [New](https://dotfyle.com/neovim/plugins/new) to find newly
  listed plugins (not necessarily newly released).

# Neovim profiles

Both profiles use this directory and require Neovim with `vim.pack` support.

- `nvim`: full configuration by default.
- `NVIM_PROFILE=lite nvim`: lightweight configuration, selected before runtime plugins load.
- Voron exports `NVIM_PROFILE=lite` through Home Manager. Restart the login session after switching; use `NVIM_PROFILE=full nvim` to override it.

Lite keeps editing, Snacks search/explorer, Gitsigns, Lua-based Blink completion,
and Bash/Lua/Nix language services (plus StyLua and nixfmt formatting).
Voron explicitly installs their dependencies, ripgrep, fd, Tree-sitter CLI and GCC.
Python/web/Rust services are not enabled in lite.

Lite skips DAP, Sidekick, OpenCode, Kitty scrollback, Mason, Rust crates, Markdown rendering,
Treesitter context, session restoration, comment boxes and smooth scrolling.
Lazygit and AI commit shortcuts are omitted. Completion uses built-in snippets
and does not load LuaSnip or dictionary providers.

Treesitter installs only Bash, Lua and Nix parsers; opening other file types does
not install additional parsers. Initial plugin/parser installation still needs
network access and writable Neovim data directories. Profiles share the usual
plugin storage and lockfile; lite does not remove existing full-profile plugins.

On hosts with an unmanaged shell, source
`~/.nix-profile/etc/profile.d/hm-session-vars.sh` from the login shell startup
file so Home Manager session variables (including `NVIM_PROFILE`) take effect.
Non-interactive SSH commands may still need `NVIM_PROFILE=lite` explicitly.

Neovim 0.12 synchronizes every entry in the shared `nvim-pack-lock.json` on
first use, including full-profile plugins. Lite skips loading those plugins,
but the shared lockfile does not prevent their initial download.
