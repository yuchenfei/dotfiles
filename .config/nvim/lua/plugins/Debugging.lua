-- References:
-- - https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/dap/core.lua
--
-- Plugins:
-- - https://github.com/mfussenegger/nvim-dap
-- - https://github.com/rcarriga/nvim-dap-ui
-- - https://github.com/theHamsta/nvim-dap-virtual-text
-- - https://github.com/jay-babu/mason-nvim-dap.nvim
-- - https://github.com/mfussenegger/nvim-dap-python

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
      {
        'jay-babu/mason-nvim-dap.nvim',
        cmd = { 'DapInstall', 'DapUninstall' },
        dependencies = { 'mason-org/mason.nvim' },
        opts = { ensure_installed = {} },
      },
      {
        'mfussenegger/nvim-dap-python',
        ft = { 'python' },
        config = function() require('dap-python').setup('uv') end,
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
      { '<leader>dc', function() require('dap').continue() end, desc = 'Run/Continue' },
      { '<F5>', function() require('dap').continue() end, desc = 'Run/Continue' },
      { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
      { '<leader>do', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<F6>', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>di', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<F7>', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>dO', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<F8>', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>dh', function() require('dap.ui.widgets').hover() end, desc = 'Hover' },
      { '<leader>dt', function() require('dap').terminate() end, desc = 'Terminate' },
      { '<leader>dl', function() require('dap').run_last() end, desc = 'Run Last' },
      { '<leader>dD', function() require('dap').clear_breakpoints() end, desc = 'Clear Breakpoints' },
      { '<leader>dP', function() require('dap').pause() end, desc = 'Pause Thread' },
      -- stylua: ignore end
    },
    config = function()
      require('which-key').add({
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
      })
      require('config.Debugging')
    end,
  },
}
