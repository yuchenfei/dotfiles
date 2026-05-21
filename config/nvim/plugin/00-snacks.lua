vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and '<c-' .. dir .. '>' or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end

---@type snacks.Config
local opts = {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = ' ',
          key = 'c',
          desc = 'Config',
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
  },
  explorer = { enabled = true },
  indent = {
    enabled = true,
    indent = {
      hl = {
        'SnacksIndent1',
        'SnacksIndent2',
        'SnacksIndent3',
        'SnacksIndent4',
        'SnacksIndent5',
        'SnacksIndent6',
        'SnacksIndent7',
        'SnacksIndent8',
      },
    },
    scope = { char = '┊' },
  },
  input = { enabled = true }, -- not for cmdline
  notifier = { enabled = true },
  picker = { enabled = true },
  scope = { enabled = true }, -- ii, ai, [i, ]i
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  terminal = {
    win = {
      keys = {
        nav_h = { '<C-h>', term_nav('h'), desc = 'Go to Left Window', expr = true, mode = 't' },
        nav_j = { '<C-j>', term_nav('j'), desc = 'Go to Lower Window', expr = true, mode = 't' },
        nav_k = { '<C-k>', term_nav('k'), desc = 'Go to Upper Window', expr = true, mode = 't' },
        nav_l = { '<C-l>', term_nav('l'), desc = 'Go to Right Window', expr = true, mode = 't' },
      },
    },
  },
  words = { enabled = true },
}

require('snacks').setup(opts)

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'snacks_picker_preview' },
  callback = function() vim.b.snacks_indent = false end,
})
