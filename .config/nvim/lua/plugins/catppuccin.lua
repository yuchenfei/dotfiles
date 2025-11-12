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
    custom_highlights = function(colors)
      return {
        -- Blink
        -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/blink_cmp.lua
        BlinkCmpMenu = { bg = colors.surface0 },
        BlinkCmpDoc = { bg = colors.surface0 },
      }
    end,
    auto_integrations = true,
  },
  init = function() vim.cmd.colorscheme('catppuccin') end,
}
