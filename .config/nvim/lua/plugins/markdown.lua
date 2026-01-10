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
            if require('zk.util').notebook_root(vim.fn.expand('%:p')) ~= nil then
              -- client.stop()
              -- vim.lsp.stop_client(client, true)
              -- vim.cmd(':LspStop ' .. client.name)
              client.server_capabilities.completionProvider = false
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
  {
    -- https://github.com/MeanderingProgrammer/render-markdown.nvim
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons',
    },
    config = function()
      require('config.markdown')
      Snacks.toggle({
        name = 'Render Markdown',
        get = require('render-markdown').get,
        set = require('render-markdown').set,
      }):map('<leader>tm')
    end,
  },
  {
    -- https://github.com/bullets-vim/bullets.vim
    'bullets-vim/bullets.vim',
    ft = { 'markdown' },
    init = function()
      vim.g.bullets_set_mappings = 0
      vim.g.bullets_custom_mappings = {
        { 'imap', '<cr>', '<Plug>(bullets-newline)' },
        { 'inoremap', '<C-cr>', '<cr>' },
        { 'nmap', 'o', '<Plug>(bullets-newline)' },

        { 'vmap', 'gN', '<Plug>(bullets-renumber)' },
        { 'nmap', 'gN', '<Plug>(bullets-renumber)' },

        { 'imap', '<C-t>', '<Plug>(bullets-demote)' },
        { 'nmap', '>>', '<Plug>(bullets-demote)' },
        { 'vmap', '>', '<Plug>(bullets-demote)' },
        { 'imap', '<C-d>', '<Plug>(bullets-promote)' },
        { 'nmap', '<<', '<Plug>(bullets-promote)' },
        { 'vmap', '<', '<Plug>(bullets-promote)' },
      }
      vim.g.bullets_pad_right = 0
      vim.g.bullets_outline_levels = { 'num' }
    end,
  },
  {
    -- https://github.com/roodolv/markdown-toggle.nvim
    'roodolv/markdown-toggle.nvim',
    ft = { 'markdown' },
    opts = {
      use_default_keymaps = false,
      enable_autolist = false, -- use bullets.vim
      keymaps = {
        toggle = {
          ['<Leader>mh'] = 'heading',
          ['<Leader>mH'] = 'heading_toggle',
          ['<Leader>ml'] = 'list',
          ['<Leader>mo'] = 'olist',
          ['<Leader>mq'] = 'quote',
          ['<Leader>mx'] = 'checkbox',
        },
        switch = {
          ['<Leader>mL'] = 'switch_cycle_list_table',
          ['<Leader>mU'] = 'switch_unmarked_only',
          ['<Leader>mX'] = 'switch_cycle_box_table',
        },
      },
    },
  },
  {
    -- https://github.com/chenxin-yan/footnote.nvim
    'chenxin-yan/footnote.nvim',
    enabled = false,
    ft = { 'markdown' },
    opts = {
      keys = {
        new_footnote = '<C-f>',
        organize_footnotes = '<leader>mF',
        next_footnote = ']f',
        prev_footnote = '[f',
      },
    },
  },
}
