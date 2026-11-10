-- Show LSP progress messages

local function fidget_setup()
  vim.pack.add({ 'https://github.com/j-hui/fidget.nvim' })
  require('fidget').setup({})
end

vim.schedule(fidget_setup)
