# Neovim profiles

Both profiles use this directory and require Neovim with `vim.pack` support.

- `nvim`: full configuration by default.
- `NVIM_PROFILE=lite nvim`: lightweight configuration, selected before runtime plugins load.
- Voron exports `NVIM_PROFILE=lite` through Home Manager. Restart the login session after switching; use `NVIM_PROFILE=full nvim` to override it.

Lite keeps editing, Snacks search/explorer, Gitsigns, Lua-based Blink completion,
and Bash/Lua/Nix language services (plus StyLua and nixfmt formatting).
Voron explicitly installs their dependencies, ripgrep, fd, Tree-sitter CLI and GCC.
Python/web/Rust services are not enabled in lite.

Lite skips DAP, OpenCode, Kitty scrollback, Mason, Rust crates, Markdown rendering,
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
