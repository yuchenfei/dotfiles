-- https://github.com/mfussenegger/nvim-lint

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    { '<leader>ll', function() require('lint').try_lint() end, desc = 'Lint buffer' },
  },
  config = function() require('config.nvim-lint') end,
}
