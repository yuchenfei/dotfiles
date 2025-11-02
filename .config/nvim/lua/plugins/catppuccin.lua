-- https://github.com/catppuccin/nvim

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    transparent_background = true,
    float = {
      transparent = true,
    },
    auto_integrations = true,
  },
  init = function() vim.cmd.colorscheme('catppuccin') end,
}
