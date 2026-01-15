-- References:
--  - https://codecompanion.olimorris.dev/installation
--  - https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua

---@type LazySpec
return {
  {
    'olimorris/codecompanion.nvim',
    version = '^18.0.0',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      opts = {
        language = '中文',
      },
      adapters = {
        acp = {
          gemini_cli = function()
            return require('codecompanion.adapters').extend('gemini_cli', {
              defaults = {
                auth_method = 'oauth-personal', -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
              },
            })
          end,
        },
        http = {
          ['cli_proxy_api'] = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              name = 'cli_proxy_api',
              formatted_name = 'CLI Proxy API',
              env = {
                url = 'http://192.168.100.2:8317',
                api_key = 'ycf-xc8ayh4nzqaw', -- local sever, it's ok.
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = {
            name = 'cli_proxy_api',
            model = 'gemini-3-pro-preview',
          },
        },
      },
    },
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
      vim.cmd([[cab cca CodeCompanionActions]])
    end,
    keys = {
      {
        '<leader>ac',
        '<cmd>CodeCompanionChat Toggle<cr>',
        mode = { 'n', 'v' },
        noremap = true,
        silent = true,
        desc = 'CodeCompanion Chat Toggle',
      },
      {
        'ga',
        '<cmd>CodeCompanionChat Add<cr>',
        mode = 'v',
        noremap = true,
        silent = true,
        desc = 'CodeCompanion Chat Add',
      },
    },
  },
}
