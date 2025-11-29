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

-- References:
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua
-- - https://github.com/microsoft/vscode-js-debug
for _, adapterType in ipairs({ 'node', 'chrome', 'msedge' }) do
  local pwaType = 'pwa-' .. adapterType

  if not dap.adapters[pwaType] then
    dap.adapters[pwaType] = {
      type = 'server',
      host = 'localhost',
      port = '${port}',
      executable = {
        command = 'js-debug-adapter',
        args = { '${port}' },
      },
    }
  end

  -- Define adapters without the "pwa-" prefix for VSCode compatibility
  if not dap.adapters[adapterType] then
    dap.adapters[adapterType] = function(cb, config)
      local nativeAdapter = dap.adapters[pwaType]

      config.type = pwaType

      if type(nativeAdapter) == 'function' then
        nativeAdapter(cb, config)
      else
        cb(nativeAdapter)
      end
    end
  end
end

local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

local vscode = require('dap.ext.vscode')
vscode.type_to_filetypes['node'] = js_filetypes
vscode.type_to_filetypes['pwa-node'] = js_filetypes

for _, language in ipairs(js_filetypes) do
  if not dap.configurations[language] then
    local runtimeExecutable = nil
    if language:find('typescript') then
      runtimeExecutable = vim.fn.executable('tsx') == 1 and 'tsx' or 'ts-node'
    end
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        runtimeExecutable = runtimeExecutable,
        skipFiles = {
          '<node_internals>/**',
          'node_modules/**',
        },
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/**',
        },
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
        sourceMaps = true,
        runtimeExecutable = runtimeExecutable,
        skipFiles = {
          '<node_internals>/**',
          'node_modules/**',
        },
        resolveSourceMapLocations = {
          '${workspaceFolder}/**',
          '!**/node_modules/**',
        },
      },
      {
        type = 'pwa-chrome',
        request = 'launch',
        name = 'Launch Chrome (nvim-dap)',
        url = 'http://localhost:5173',
        webRoot = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '**/node_modules/**' },
        preLaunchTask = 'bun dev',
      },
      {
        type = 'pwa-msedge',
        request = 'launch',
        name = 'Launch Edge (nvim-dap)',
        url = 'http://localhost:5173',
        webRoot = '${workspaceFolder}',
        sourceMaps = true,
        skipFiles = { '**/node_modules/**' },
        preLaunchTask = 'bun dev',
      },
    }
  end
end
