-- Refferences:
-- - https://github.com/nvim-lualine/lualine.nvim
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
-- - https://github.com/AndreM222/copilot-lualine

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'AndreM222/copilot-lualine' },
  event = 'VeryLazy',
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  config = function() require('config.lualine') end,
}
