-- References:
-- - https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua
--
-- Plugins:
-- - https://github.com/mfussenegger/nvim-dap
-- - https://github.com/rcarriga/nvim-dap-ui
-- - https://github.com/theHamsta/nvim-dap-virtual-text

---@type LazySpec
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = { 'nvim-neotest/nvim-nio' },
        opts = {},
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      { 'mason-org/mason.nvim' },
      {
        'folke/which-key.nvim',
        opts = {
          spec = {
            { '<leader>d', group = 'debug' },
            { '<leader>db', icon = '' },
            { '<leader>dB', icon = '' },
            { '<leader>dc', icon = '' },
            { '<leader>dC', icon = '' },
            { '<leader>do', icon = '' },
            { '<leader>di', icon = '' },
            { '<leader>dO', icon = '' },
            { '<leader>dt', icon = '' },
            { '<leader>dD', icon = '󰶽' },
            { '<leader>dP', icon = '󰏨' },
          },
        },
      },
    },
    keys = {
      { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
      { '<leader>de', function() require('dapui').eval() end, desc = 'Eval', mode = { 'n', 'x' } },

      {
        '<leader>dB',
        function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
        desc = 'Breakpoint Condition',
      },
      -- stylua: ignore start
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dc', function() require('dap').continue() end,          desc = 'Run/Continue' },
      { '<F5>',       function() require('dap').continue() end,          desc = 'Run/Continue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end,     desc = 'Run to Cursor' },
      { '<leader>do', function() require('dap').step_over() end,         desc = 'Step Over' },
      { '<F6>',       function() require('dap').step_over() end,         desc = 'Step Over' },
      { '<leader>di', function() require('dap').step_into() end,         desc = 'Step Into' },
      { '<F7>',       function() require('dap').step_into() end,         desc = 'Step Into' },
      { '<leader>dO', function() require('dap').step_out() end,          desc = 'Step Out' },
      { '<F8>',       function() require('dap').step_out() end,          desc = 'Step Out' },
      { '<leader>dr', function() require('dap').repl.toggle() end,       desc = 'Toggle REPL' },
      { '<leader>dh', function() require('dap.ui.widgets').hover() end,  desc = 'Hover' },
      { '<leader>dt', function() require('dap').terminate() end,         desc = 'Terminate' },
      { '<leader>dl', function() require('dap').run_last() end,          desc = 'Run Last' },
      { '<leader>dD', function() require('dap').clear_breakpoints() end, desc = 'Clear Breakpoints' },
      { '<leader>dP', function() require('dap').pause() end,             desc = 'Pause Thread' },
      -- stylua: ignore end
    },
    config = function()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
      local dap_signs = {
        Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
        Breakpoint = ' ',
        BreakpointCondition = ' ',
        BreakpointRejected = { ' ', 'DiagnosticError' },
        LogPoint = '.>',
      }
      for name, sign in pairs(dap_signs) do
        sign = type(sign) == 'table' and sign or { sign }
        vim.fn.sign_define('Dap' .. name, {
          text = sign[1],
          texthl = sign[2] or 'DiagnosticInfo',
          linehl = sign[3],
          numhl = sign[3],
        })
      end

      local dap = require('dap')
      local dapui = require('dapui')
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },
}
