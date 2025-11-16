-- https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatEnable', 'FormatDisable' },
  keys = {
    {
      '<leader>lf',
      function() require('conform').format({ async = true }) end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  config = function() require('config.conform') end,
}
