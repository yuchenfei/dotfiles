-- References:
-- - https://github.com/mfussenegger/nvim-lint
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/linting.lua

local lint = require('lint')

lint.linters_by_ft = {
  markdown = { 'markdownlint-cli2' },
  nix = { 'statix' }, -- Installed via nixpkgs
  python = { 'ruff' },
}

local linters = {}

for name, linter in pairs(linters) do
  if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
    lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
    if type(linter.prepend_args) == 'table' then
      lint.linters[name].args = lint.linters[name].args or {}
      vim.list_extend(lint.linters[name].args, linter.prepend_args)
    end
  else
    lint.linters[name] = linter
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('nvim-lint', { clear = true }),
  callback = function() lint.try_lint() end,
})
