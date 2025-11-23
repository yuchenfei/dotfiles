-- Split and join arguments
-- https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-splitjoin.md

return {
  'nvim-mini/mini.splitjoin',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    mappings = {
      toggle = 'gS',
      split = '',
      join = '',
    },
  },
}
