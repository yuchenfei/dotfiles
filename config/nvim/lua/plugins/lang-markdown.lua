---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'markdown', 'markdown_inline' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        marksman = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
      },
      setup = {
        marksman = function()
          Snacks.util.lsp.on({ name = 'marksman' }, function(_, client)
            if require('obsidian.api').path_is_note(vim.fn.expand('%:p')) == true then
              client.server_capabilities.completionProvider = false
              client.server_capabilities.definitionProvider = false
              client.server_capabilities.referencesProvider = false
              client.server_capabilities.documentSymbolProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = {
      ensure_installed = {
        'markdownlint-cli2', -- https://github.com/DavidAnson/markdownlint-cli2
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
      },
      linters = {
        ['markdownlint-cli2'] = {
          prepend_args = {
            '--config',
            vim.fn.expand('~') .. '/.config/.markdownlint-cli2.jsonc',
          },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        markdown = { 'prettier', 'markdownlint-cli2', 'injected' },
      },
      formatters = {
        ['markdownlint-cli2'] = {
          prepend_args = {
            '--config',
            vim.fn.expand('~') .. '/.config/.markdownlint-cli2.jsonc',
          },
          condition = function(_, ctx)
            local diag = vim.tbl_filter(
              function(d) return d.source == 'markdownlint' end,
              vim.diagnostic.get(ctx.buf)
            )
            return #diag > 0
          end,
        },
      },
    },
  },
}
