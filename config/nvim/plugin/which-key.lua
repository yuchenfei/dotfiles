vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

---@type wk.Opts
local opts = {
  preset = 'helix',
  spec = {
    {
      mode = { 'n', 'x' }, -- Nested mappings
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Comment Box', icon = '󰃔' },
      { '<leader>f', group = 'Find' },
      { '<leader>g', group = 'Git' },
      { '<leader>h', group = 'Hunks', icon = '' },
      { '<leader>l', group = 'LSP', icon = '' },
      { '<leader>o', group = 'Opencode', icon = '󰚩' },
      { '<leader>q', group = 'Quit' },
      { '<leader>R', icon = '󰜉' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>u', group = 'UI' },
      { 'gs', group = 'Surround' },
    },
  },
}

require('which-key').setup(opts)
