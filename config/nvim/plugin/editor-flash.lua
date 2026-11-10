---@type Flash.Config
local opts = {
  jump = {
    autojump = true,
  },
  label = {
    rainbow = {
      enabled = true,
    },
  },
  modes = {
    -- options used when flash is activated through
    -- `f`, `F`, `t`, `T`, `;` and `,` motions
    char = {
      jump_labels = true,
    },
  },
}

local function map(key, func, desc, mode)
  mode = mode or { 'n', 'x', 'o' }
  vim.keymap.set(mode, key, func, { desc = desc })
end

local function flash_setup()
  vim.pack.add({ 'https://github.com/folke/flash.nvim' })

  require('flash').setup(opts)

  map('s', function() require('flash').jump() end, 'Flash')
  map('S', function() require('flash').treesitter() end, 'Flash Treesitter')
  map('r', function() require('flash').remote() end, 'Remote Flash', 'o')
  map('R', function() require('flash').treesitter_search() end, 'Treesitter Search', { 'o', 'x' })
  map('<c-s>', function() require('flash').toggle() end, 'Toggle Flash Search', 'c')
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('flash-setup', { clear = true }),
  once = true,
  callback = flash_setup,
})

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('kitty-flash-setup', { clear = true }),
  pattern = 'KittyScrollbackLaunch',
  once = true,
  callback = flash_setup,
})
