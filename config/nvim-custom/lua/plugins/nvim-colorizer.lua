-- https://github.com/catgoose/nvim-colorizer.lua

return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = {
      '*', -- Highlight all files, but customize some others.
      '!markdown', -- Exclude vim from highlighting.
      lua = { -- use different theme for lua filetype
        names_custom = function() return require('catppuccin.palettes').get_palette('mocha') end,
      },
    },
    lazy_load = true,
    user_default_options = {
      names = true,
      -- names_custom = function() return require('catppuccin.palettes').get_palette('mocha') end,
    },
  },
}
