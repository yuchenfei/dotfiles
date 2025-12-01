---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'lua', 'luadoc' } },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        lua_ls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
      },
    },
  },
  {
    'mason-org/mason.nvim',
    opts = { ensure_installed = { 'stylua' } },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    --
    -- https://github.com/folke/lazydev.nvim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'mini.icons', words = { 'MiniIcons' } },
      },
    },
  },
}
