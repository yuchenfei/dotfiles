-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Toggle theme based on background
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    local background = vim.o.background
    os.execute("fish -c 'toggle_theme " .. background .. "'")
  end,
})

-- Auto organize imports on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("ts_organize_imports", { clear = true }),
  pattern = "*.tsx,*.ts",
  callback = function()
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
    vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
  end,
})
