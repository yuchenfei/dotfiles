---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'nix' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      nil_ls = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nil_ls
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        nix = { 'statix' }, -- Installed via nixpkgs
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { 'nixfmt' }, -- Installed via nixpkgs
      },
    },
  },
}
