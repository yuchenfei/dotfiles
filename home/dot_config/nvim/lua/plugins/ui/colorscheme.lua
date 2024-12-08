-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  {
    'folke/tokyonight.nvim', -- https://github.com/folke/tokyonight.nvim
    -- priority = 1000, -- Make sure to load this before all the other start plugins.
    lazy = true,
  },
  {
    'catppuccin/nvim', -- https://github.com/catppuccin/nvim
    -- priority = 1000,
    lazy = true,
    name = 'catppuccin',
    config = function()
      require('catppuccin').setup({
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          mason = true,
          mini = {
            enabled = true,
            indentscope_color = 'sky',
          },
          neotree = true,
          notify = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
      })
    end,
  },
}
