-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/nil_ls.lua
-- https://github.com/oxalica/nil

---@type vim.lsp.Config
return {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', '.git' },
}
