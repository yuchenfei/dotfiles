-- https://github.com/mfussenegger/nvim-lint

local lint = require('lint')

lint.linters_by_ft = {
  nix = { 'statix' }, -- Installed via nixpkgs
}

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
  callback = function() lint.try_lint() end,
})
