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

vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
-- stylua: ignore
local dap_signs = {
  Stopped             = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
  Breakpoint          = ' ',
  BreakpointCondition = ' ',
  BreakpointRejected  = { ' ', 'DiagnosticError' },
  LogPoint            = '.>',
}
for name, sign in pairs(dap_signs) do
  sign = type(sign) == 'table' and sign or { sign }
  vim.fn.sign_define(
    'Dap' .. name,
    { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
  )
end

local dap = require('dap')
local dapui = require('dapui')

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

require('overseer').enable_dap()
