-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false

-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true

-- only for diagnostics. The rest of LSP support will still be
-- provided by rust-analyzer.
vim.g.lazyvim_rust_diagnostics = "bacon-ls"

vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_cmp = "blink.cmp"
vim.g.ai_cmp = false

vim.opt.background = "dark"

vim.opt.wrap = true
vim.opt.breakindent = true
