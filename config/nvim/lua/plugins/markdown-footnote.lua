-- References:
--  - https://github.com/chenxin-yan/footnote.nvim

---@type LazySpec
return {
  'chenxin-yan/footnote.nvim',
  enabled = false,
  ft = { 'markdown' },
  opts = {
    keys = {
      new_footnote = '<C-f>',
      organize_footnotes = '<leader>mF',
      next_footnote = ']f',
      prev_footnote = '[f',
    },
  },
}
