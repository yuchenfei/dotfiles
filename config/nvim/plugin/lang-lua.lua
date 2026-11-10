local function lazydev_setup()
  vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })

  require('lazydev').setup({
    library = {
      'nvim-lspconfig',
      { path = 'snacks.nvim', words = { 'Snacks' } },
    },
  })
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('lazydev-setup', { clear = true }),
  pattern = 'lua',
  once = true,
  callback = lazydev_setup,
})
