-- Useful plugin to show you pending keybinds.
-- https://github.com/folke/which-key.nvim

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- Document existing key chains
    spec = {
      { '<leader>b', group = 'buffer' },
      { '<leader>g', group = 'git' },
      { '<leader>l', group = 'lsp/code' },
      { '<leader>q', group = 'quit/session' },
      { '<leader>s', group = 'search' },
      -- { '<leader>t', group = 'toggle' },
      { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
      {
        '<leader>w',
        group = 'windows',
        proxy = '<c-w>',
        expand = function()
          return require('which-key.extras').expand.win()
        end,
      },
      -- better descriptions
      { 'gx', desc = 'Open with system app' },
    },
    icons = {
      group = '',
    },
  },
}
