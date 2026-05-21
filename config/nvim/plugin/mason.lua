local function mason_setup()
  vim.pack.add({ 'https://github.com/mason-org/mason.nvim' })
  require('mason').setup()
end

vim.schedule(mason_setup)

vim.keymap.set('n', '<leader>lm', '<cmd>Mason<cr>', { desc = 'Mason' })
