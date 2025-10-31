-- https://github.com/folke/which-key.nvim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua

return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    preset = 'modern',
    icons = {
      keys = {
        BS = '􁂉 ',
      },
    },

    -- Document existing key chains
    spec = {
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git', mode = { 'n', 'v' }, icon = '' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '[', group = 'Previous' },
      { ']', group = 'Next' },
      { 'g', group = 'Go to', icon = '󰿅' },
      { 'z', group = 'Fold' },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
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
