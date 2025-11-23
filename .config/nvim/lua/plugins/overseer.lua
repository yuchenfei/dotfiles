-- https://github.com/stevearc/overseer.nvim

return {
  'stevearc/overseer.nvim',
  cmd = {
    'OverseerRun',
    'OverseerTaskAction',
    'OverseerToggle',
  },
  keys = {
    { '<leader>oo', '<cmd>OverseerToggle<cr>', desc = 'Toggle task list' },
    { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Run task' },
    { '<leader>oa', '<cmd>OverseerTaskAction<cr>', desc = 'Task action list' },
  },
  config = function() require('config.overseer') end,
}
