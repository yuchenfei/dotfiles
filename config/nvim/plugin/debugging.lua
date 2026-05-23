local dap_core_setup_done = false
local dap_python_setup_done = false
local dap_js_setup_done = false

local function setup_dap_core()
  if dap_core_setup_done then return end

  vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
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

  dap_core_setup_done = true
end

local function setup_dap_python()
  if dap_python_setup_done then return end

  setup_dap_core()

  vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap-python',
  })

  require('dap-python').setup('uv')

  dap_python_setup_done = true
end

local function setup_dap_js()
  if dap_js_setup_done then return end

  setup_dap_core()

  local dap = require('dap')

  -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript/init.lua
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

  local function js_project_root()
    local current_file = vim.api.nvim_buf_get_name(0)
    local search_path = current_file ~= '' and current_file or vim.uv.cwd()
    local markers = vim.fs.find({ 'vite.config.ts', 'vite.config.js', 'package.json' }, {
      upward = true,
      path = search_path,
    })

    return markers[1] and vim.fs.dirname(markers[1]) or vim.uv.cwd()
  end

  local function vite_source_map_overrides()
    local root = js_project_root()

    return {
      ['/@fs/*'] = '/*',
      ['/src/*'] = root .. '/src/*',
      ['vite:///*'] = root .. '/*',
      ['webpack:///*'] = root .. '/*',
    }
  end

  local function js_resolve_source_map_locations()
    return {
      js_project_root() .. '/**',
      '!**/node_modules/**',
    }
  end

  local vscode = require('dap.ext.vscode')
  vscode.type_to_filetypes['node'] = js_filetypes
  vscode.type_to_filetypes['pwa-node'] = js_filetypes

  for _, language in ipairs(js_filetypes) do
    if not dap.configurations[language] then
      local runtimeExecutable = nil
      if language:find('typescript') then runtimeExecutable = vim.fn.executable('tsx') == 1 and 'tsx' or 'ts-node' end
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
          cwd = js_project_root,
          webRoot = js_project_root,
          sourceMaps = true,
          skipFiles = { '**/node_modules/**' },
          resolveSourceMapLocations = js_resolve_source_map_locations,
          sourceMapPathOverrides = vite_source_map_overrides,
          preLaunchTask = 'bun dev',
        },
        {
          type = 'pwa-msedge',
          request = 'launch',
          name = 'Launch Edge (nvim-dap)',
          url = 'http://localhost:5173',
          cwd = js_project_root,
          webRoot = js_project_root,
          sourceMaps = true,
          skipFiles = { '**/node_modules/**' },
          resolveSourceMapLocations = js_resolve_source_map_locations,
          sourceMapPathOverrides = vite_source_map_overrides,
          preLaunchTask = 'bun dev',
        },
      }
    end
  end

  dap_js_setup_done = true
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('debugging-python-setup', { clear = true }),
  pattern = 'python',
  callback = setup_dap_python,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('debugging-js-setup', { clear = true }),
  pattern = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
  callback = setup_dap_js,
})
