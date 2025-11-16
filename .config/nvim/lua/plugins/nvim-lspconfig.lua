-- https://github.com/neovim/nvim-lspconfig

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function() require('config.lsp') end,
}
