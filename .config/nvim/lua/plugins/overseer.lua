-- https://github.com/stevearc/overseer.nvim

---@type LazySpec
return {
  {
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
    -- https://github.com/stevearc/overseer.nvim/blob/master/doc/reference.md#setup-options
    opts = {
      dap = false,
      task_list = {
        direction = 'bottom',
        keymaps = {
          ['k'] = 'keymap.prev_task',
          ['j'] = 'keymap.next_task',
          ['<C-k>'] = false,
          ['<C-j>'] = false,
        },
      },
      -- Aliases for bundles of components. Redefine the builtins, or create your own.
      component_aliases = {
        -- Most tasks are initialized with the default components
        default = {
          'on_exit_set_status',
          'on_complete_notify',
          { 'on_complete_dispose', require_view = { 'SUCCESS', 'FAILURE' } },
        },
        -- Tasks from tasks.json use these components
        default_vscode = {
          'default',
          'on_result_diagnostics',
        },
      },
    },
  },
  {
    'mfussenegger/nvim-dap',
    opts = function() require('overseer').enable_dap() end,
  },
}
