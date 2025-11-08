-- https://github.com/rebelot/heirline.nvim

return {
  'rebelot/heirline.nvim',
  dependencies = {
    'nvim-mini/mini.icons',
  },
  event = { 'BufReadPre', 'BufNewFile' },
  config = function() require('config.heirline') end,
}
