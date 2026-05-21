local function debugging_setup()
  vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/mfussenegger/nvim-dap-python',
  })

  require('which-key').add({
    { '<leader>d', group = 'Debug' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint', icon = '' },
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = 'Conditional Breakpoint',
      icon = '',
    },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Start/Continue', icon = '' },
    { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor', icon = '' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into', icon = '' },
    { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out', icon = '' },
    { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over', icon = '' },
    { '<leader>dp', function() require('dap').pause() end, desc = 'Pause', icon = '󰏨' },
    { '<leader>dq', function() require('dap').close() end, desc = 'Close', icon = '󰈆' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate', icon = '' },
    { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI', icon = '' },
    { '<leader>dw', function() require('dap').clear_breakpoints() end, desc = 'Wipe Breakpoints', icon = '󰮈' },
  })

  -- Custom breakpoint style
  vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'QuickFixLine' })
  local sign = vim.fn.sign_define
  sign('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
  sign('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
  sign('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })
  sign('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
  sign('DapStopped', { text = '󰁕', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' })

  local dap = require('dap')
  local dapui = require('dapui')

  dapui.setup()

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  require('nvim-dap-virtual-text').setup({
    commented = true,
    all_frames = true,
    virt_text_pos = 'eol',
  })

  require('dap-python').setup('uv')
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('debugging-setup', { clear = true }),
  pattern = { 'python' },
  once = true,
  callback = debugging_setup,
})
