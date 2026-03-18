---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'ninja', 'python' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        -- pyrefly = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyrefly.lua
        basedpyright = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#basedpyright
          -- https://docs.basedpyright.com/latest/configuration/language-server-settings
          settings = {
            basedpyright = {
              -- Using Ruff's import organizer
              disableOrganizeImports = false,
            },
          },
        },
        ruff = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#ruff
          -- https://docs.astral.sh/ruff/editors/setup/#neovim
          init_options = {
            settings = {
              -- Ruff language server settings go here
              logLevel = 'error',
            },
          },
        },
      },
      setup = {
        ruff = function()
          Snacks.util.lsp.on({ name = 'ruff' }, function(_, client)
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end)
        end,
      },
    },
  },
  -- linting by lsp
  -- {
  --   'mfussenegger/nvim-lint',
  --   opts = {
  --     linters_by_ft = {
  --       python = { 'ruff' },
  --     },
  --   },
  -- },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        -- https://github.com/mfussenegger/nvim-dap-python
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        config = function() require('dap-python').setup('uv') end,
      },
    },
  },
}
