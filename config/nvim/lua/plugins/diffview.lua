-- https://github.com/sindrets/diffview.nvim

---@type LazySpec
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
  keys = {
    {
      '<leader>go',
      function()
        local view = require('diffview.lib').get_current_view()
        if view then
          vim.cmd([[DiffviewClose]])
        else
          vim.cmd([[DiffviewOpen]])
        end
      end,
      desc = 'DiffView Toggle',
    },
    {
      '<leader>gh',
      function()
        local view = require('diffview.lib').get_current_view()
        if view then
          vim.cmd([[DiffviewClose]])
        else
          vim.cmd([[DiffviewFileHistory %]])
        end
      end,
      desc = 'DiffView History',
    },
  },
  opts = {},
}
