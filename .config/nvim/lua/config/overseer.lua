-- https://github.com/stevearc/overseer.nvim/blob/master/doc/reference.md#setup-options

require('overseer').setup({
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
})
