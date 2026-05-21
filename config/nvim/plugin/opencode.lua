local opencode_cmd = 'opencode --port'

---@type snacks.terminal.Opts
local snacks_terminal_opts = {
  win = {
    position = 'right',
    enter = false,
    on_win = function(win)
      -- Set up keymaps and cleanup for an arbitrary terminal
      require('opencode.terminal').setup(win.win)
    end,
  },
}

local opencode_loaded = false

local function load_opencode()
  if opencode_loaded then return require('opencode') end

  vim.pack.add({ 'https://github.com/nickjvandyke/opencode.nvim' })

  ---@type opencode.Opts
  vim.g.opencode_opts = {
    server = {
      start = function() require('snacks.terminal').open(opencode_cmd, snacks_terminal_opts) end,
      stop = function() require('snacks.terminal').get(opencode_cmd, snacks_terminal_opts):close() end,
      toggle = function() require('snacks.terminal').toggle(opencode_cmd, snacks_terminal_opts) end,
    },
  }

  vim.o.autoread = true -- Required for `opts.events.reload`

  local opencode = require('opencode')

  opencode_loaded = true
  return opencode
end

vim.keymap.set(
  { 'n', 'x' },
  '<leader>oa',
  function() load_opencode().ask('@this: ', { submit = true }) end,
  { desc = 'Ask opencode…' }
)
vim.keymap.set(
  { 'n', 'x' },
  '<leader>ox',
  function() load_opencode().select() end,
  { desc = 'Execute opencode action…' }
)
vim.keymap.set({ 'n', 't' }, '<leader>oo', function() load_opencode().toggle() end, { desc = 'Toggle opencode' })
