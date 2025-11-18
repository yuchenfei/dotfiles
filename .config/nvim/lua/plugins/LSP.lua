-- https://github.com/neovim/nvim-lspconfig

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
  },
  event = 'VeryLazy',
  config = function() require('config.LSP') end,
}
