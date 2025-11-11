-- https://github.com/mason-org/mason.nvim
-- https://github.com/mason-org/mason-lspconfig.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      {
        'mason-org/mason.nvim',
        keys = {
          { '<leader>lm', function() require('mason.ui').open() end, desc = 'Mason' },
        },
        opts = {},
      },
      -- can be installed for the option to use lspconfig names instead of Mason names.
      'mason-org/mason-lspconfig.nvim',
    },
    opts = {
      ensure_installed = {
        -- Lua
        'lua_ls',
        'stylua',
      },
    },
  },
}
