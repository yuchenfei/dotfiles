local function splitjoin_setup()
  vim.pack.add({ 'https://github.com/nvim-mini/mini.splitjoin' })

  require('mini.splitjoin').setup({
    mappings = {
      toggle = 'gS',
      split = '',
      join = '',
    },
  })
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('mini-splitjoin-setup', { clear = true }),
  once = true,
  callback = splitjoin_setup,
})
