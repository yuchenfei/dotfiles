if vim.g.nvim_lite then return end

local sidekick_cli

local function load_sidekick()
  if sidekick_cli then return sidekick_cli end

  vim.pack.add({ 'https://github.com/folke/sidekick.nvim' })

  -- GUI/managed shells may not include Homebrew in PATH.
  local agy = 'agy'
  if vim.fn.executable(agy) == 0 and vim.fn.executable('/opt/homebrew/bin/agy') == 1 then
    agy = '/opt/homebrew/bin/agy'
  end

  require('sidekick').setup({
    nes = { enabled = false },
    cli = {
      win = { layout = 'right' },
      mux = { enabled = false },
      tools = {
        codex = {}, -- Use Sidekick's built-in Codex configuration.
        agy = {
          cmd = { agy },
          is_proc = '\\<agy\\>',
          url = 'https://antigravity.google/docs/cli/overview',
        },
      },
    },
  })

  sidekick_cli = require('sidekick.cli')
  return sidekick_cli
end

-- setup() replaces this entry point with Sidekick's native command.
vim.api.nvim_create_user_command('Sidekick', function(args)
  load_sidekick()
  require('sidekick.commands').cmd(args)
end, { nargs = '?', range = true, desc = 'Sidekick' })

vim.keymap.set('n', '<leader>aa', function() load_sidekick().toggle() end, { desc = 'Toggle AI CLI' })
vim.keymap.set('n', '<leader>as', function()
  load_sidekick().select({ filter = { installed = true } })
end, { desc = 'Select AI CLI' })
vim.keymap.set('n', '<leader>ac', function()
  load_sidekick().toggle({ name = 'codex', focus = true })
end, { desc = 'Toggle Codex' })
vim.keymap.set('n', '<leader>ag', function()
  load_sidekick().toggle({ name = 'agy', focus = true })
end, { desc = 'Toggle Antigravity' })
vim.keymap.set({ 'n', 'x' }, '<leader>at', function()
  load_sidekick().send({ msg = '{this}' })
end, { desc = 'Send This to AI' })
vim.keymap.set('n', '<leader>af', function() load_sidekick().send({ msg = '{file}' }) end, { desc = 'Send File to AI' })
vim.keymap.set({ 'n', 'x' }, '<leader>ap', function() load_sidekick().prompt() end, { desc = 'Select AI Prompt' })
vim.keymap.set('n', '<leader>ad', function() load_sidekick().close() end, { desc = 'Detach AI CLI' })
