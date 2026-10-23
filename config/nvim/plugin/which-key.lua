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

if vim.g.nvim_lite then
  local group = { mode = opts.spec[1].mode }
  for _, item in ipairs(opts.spec[1]) do
    if item[1] ~= '<leader>o' and item[1] ~= '<leader>c' then group[#group + 1] = item end
  end
  opts.spec[1] = group
end

require('which-key').setup(opts)
