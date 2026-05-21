-- ╭─────────────────────────────────────────────────────────╮
-- │                       FOUNDATION                        │
-- ╰─────────────────────────────────────────────────────────╯

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require('config.options')
require('config.keymaps')
require('config.autocmds')

-- ╭─────────────────────────────────────────────────────────╮
-- │                         PLUGINS                         │
-- ╰─────────────────────────────────────────────────────────╯
-- `vim.pack` is a new plugin manager built into Neovim,
-- which provides a Lua interface for installing and managing plugins.
--
-- See `:help vim.pack`, `:help vim.pack-examples` or the
-- excellent blog post from the creator of vim.pack and mini.nvim:
-- https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
--
-- To inspect plugin state and pending updates, run
--   :lua vim.pack.update(nil, { offline = true })
--
-- To update plugins, run
--   :lua vim.pack.update()

-- The `plugin/` runtime files are sourced automatically during startup by Neovim itself.
