---@type LazySpec
return {
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons',
    },
    -- Also config in opts.file_types
    ft = { 'markdown', 'Avante' },
    config = function()
      require('config.markdown')
      Snacks.toggle({
        name = 'Render Markdown',
        get = require('render-markdown').get,
        set = require('render-markdown').set,
      }):map('<leader>tm')
    end,
  },
  -- https://github.com/bullets-vim/bullets.vim
  {
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
  -- https://github.com/roodolv/markdown-toggle.nvim
  {
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
}
