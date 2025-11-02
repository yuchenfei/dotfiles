-- https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'FormatEnable', 'FormatDisable' },
  keys = {
    {
      '<leader>lf',
      function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  config = function() require('custom.config.conform') end,
}
