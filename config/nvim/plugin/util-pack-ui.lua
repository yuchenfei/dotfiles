local pack_ui

local function load_pack_ui()
  if pack_ui then return pack_ui end

  -- Keep our command entry points when vim.pack sources the plugin runtime.
  vim.g.loaded_pack_ui = true
  vim.pack.add({ 'https://github.com/jtprogru/pack-ui.nvim' })

  local ui = require('pack_ui')
  ui.setup({
    border = 'rounded',
    auto_check = false,
    auto_update = false,
    keymaps = false,
  })

  pack_ui = ui
  return pack_ui
end

vim.api.nvim_create_user_command('PackStatus', function() load_pack_ui().status() end, { desc = 'Plugin Status' })
vim.api.nvim_create_user_command(
  'PackUpdate',
  function() load_pack_ui().update() end,
  { desc = 'Check Plugin Updates' }
)
vim.api.nvim_create_user_command(
  'PackUpdateAll',
  function() load_pack_ui().update_all() end,
  { desc = 'Update All Plugins' }
)

vim.keymap.set('n', '<leader>ps', '<cmd>PackStatus<cr>', { desc = 'Plugin Status' })
vim.keymap.set('n', '<leader>pu', '<cmd>PackUpdate<cr>', { desc = 'Check Plugin Updates' })
vim.keymap.set('n', '<leader>pU', '<cmd>PackUpdateAll<cr>', { desc = 'Update All Plugins' })
