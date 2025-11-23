-- https://github.com/catgoose/nvim-colorizer.lua

return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    lazy_load = true,
    user_default_options = {
      names = true,
      names_custom = function() return require('catppuccin.palettes').get_palette('mocha') end,
    },
  },
}
