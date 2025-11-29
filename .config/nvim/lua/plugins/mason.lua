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
    config = function(_, opts)
      require('mason').setup(opts)

      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39#issue-2080773359
      vim.api.nvim_command('MasonToolsInstall')
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      -- can be installed for the option to use lspconfig names instead of Mason names.
      { 'mason-org/mason-lspconfig.nvim', config = function() end },
    },
    cmd = 'MasonToolsInstall',
    opts = {
      ensure_installed = {
        'tree-sitter-cli',
        'html',
        'jsonls',
        'prettier',
        -- Lua
        'lua_ls',
        'stylua',
        -- Nix
        'nil_ls',
        -- Markdown
        'marksman',
        'markdownlint-cli2', -- https://github.com/DavidAnson/markdownlint-cli2
        -- Python
        'basedpyright',
        'pyrefly',
        'ruff', -- https://docs.astral.sh/ruff/editors/setup/
        -- TypeScript/JavaScript
        'vtsls',
        'biome',
        'js-debug-adapter',
      },
    },
  },
}
