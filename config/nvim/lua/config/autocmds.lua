-- ╓
-- ║ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- ║ https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- ║ https://neovim.io/doc/user/autocmd/#autocmd
-- ╙

-- ╭─────────────────────────────────────────────────────────╮
-- │                   Basic Autocommands                    │
-- ╰─────────────────────────────────────────────────────────╯
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  -- See `:help vim.hl.on_yank()`
  callback = function() vim.hl.on_yank() end,
})
