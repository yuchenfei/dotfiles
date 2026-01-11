-- https://github.com/folke/which-key.nvim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    icons = {
      keys = {
        BS = '􁂉 ',
      },
    },
    -- Document existing key chains
    spec = {
      { '<leader>a', group = 'AI', icon = '󰚩' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git', mode = { 'n', 'v' }, icon = '' },
      { '<leader>l', group = 'LSP', icon = '' },
      { '<leader>m', group = 'Markdown', icon = '󰍔' },
      { '<leader>n', group = 'Noice' },
      { '<leader>o', group = 'Overseer', icon = '󰑮' },
      { '<leader>p', icon = '' },
      { '<leader>q', group = 'Quit/Session' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', icon = '󰳻' },
      { '[', group = 'Previous' },
      { ']', group = 'Next' },
      { 'g', group = 'Go to', icon = '󰿅' },
      { 'ga', group = 'LSP: Calls' },
      { 'z', group = 'Fold' },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
      {
        '<leader>b',
        group = 'Buffer',
        icon = '',
        expand = function() return require('which-key.extras').expand.buf() end,
      },
    },
  },
  keys = {
    {
      '<leader>?',
      function() require('which-key').show({ global = false }) end,
      desc = 'Buffer Keymaps (which-key)',
    },
  },
}
