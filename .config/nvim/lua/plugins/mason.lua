-- https://github.com/mason-org/mason.nvim
-- https://github.com/mason-org/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

return {
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    keys = { { '<leader>lm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts = {},
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      -- can be installed for the option to use lspconfig names instead of Mason names.
      'mason-org/mason-lspconfig.nvim',
    },
    config = function() require('config.mason') end,
  },
}
