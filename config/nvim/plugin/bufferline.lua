---@type bufferline.UserConfig
local opts = {
  options = {
    mode = 'tabs',
    offsets = {
      {
        filetype = 'snacks_layout_box',
      },
    },
  },
  highlights = require('catppuccin.special.bufferline').get_theme(),
}

local function bufferline_setup()
  vim.pack.add({ 'https://github.com/akinsho/bufferline.nvim' })
  require('bufferline').setup(opts)
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('bufferline-setup', { clear = true }),
  once = true,
  callback = bufferline_setup,
})
