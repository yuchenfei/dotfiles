-- References:
-- - https://github.com/nvim-lua/kickstart.nvim
-- - https://github.com/LazyVim/LazyVim
-- - https://github.com/AstroNvim/AstroNvim

require('options')
require('keymaps')
require('autocmds')

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.ui' },
  { import = 'plugins.editor' },
  { import = 'plugins.tool' },
})

-- [[ Colorscheme ]]
-- ttokyonight-day, tokyonight-moon, tokyonight-storm, okyonight-night
-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.cmd.colorscheme('catppuccin-mocha')
-- You can configure highlights by doing something like:
vim.cmd.hi('Comment gui=none')
