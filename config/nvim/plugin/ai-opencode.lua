if vim.g.nvim_lite then return end

local opencode_cmd = 'opencode'

---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
  },
}

local opencode_loaded = false

local function load_opencode()
  if opencode_loaded then return require('opencode') end

  ---@type opencode.Opts
  vim.g.opencode_opts = {
    server = {
      start = function() require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts) end,
    },
  }

  -- main supports OpenCode v2; stable releases target v1.
  vim.pack.add({ { src = 'https://github.com/nickjvandyke/opencode.nvim', version = 'main' } })

  local opencode = require('opencode')

  opencode_loaded = true
  return opencode
end

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() load_opencode().ask('@this: ') end, { desc = 'Ask opencode…' })
vim.keymap.set(
  { 'n', 'x' },
  '<leader>ox',
  function() load_opencode().select() end,
  { desc = 'Execute opencode action…' }
)
vim.keymap.set('n', '<leader>oo', function()
  load_opencode()
  require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts)
end, { desc = 'Toggle opencode' })
