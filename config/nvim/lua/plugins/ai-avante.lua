-- References:
--  - https://github.com/yetone/avante.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/ai/avante.lua

---@type LazySpec
return {
  {
    'yetone/avante.nvim',
    build = vim.fn.has('win32') ~= 0
        and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      or 'make',
    event = 'VeryLazy',
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = 'gemini',
      providers = {
        gemini = {
          endpoint = 'http://192.168.100.2:8317/v1beta/models',
          model = 'gemini-3-pro-high',
        },
      },
      behaviour = {
        auto_add_current_file = false,
      },
      mappings = {
        ask = '<leader>aa',
        new_ask = '<leader>an',
        zen_mode = '<leader>az',
        edit = '<leader>ae',
        refresh = '<leader>ar',
        focus = '<leader>af',
        stop = '<leader>as',
        toggle = {
          default = nil,
          debug = '<leader>aD',
          selection = '<leader>aC',
          suggestion = nil,
          repomap = '<leader>aR',
        },
        files = {
          add_current = '<leader>ab',
          add_all_buffers = '<leader>aB',
        },
        select_model = '<leader>am',
        select_history = '<leader>ah',
        sidebar = {
          apply_all = 'A',
          apply_cursor = 'a',
          retry_user_request = 'r',
          edit_user_request = 'e',
          switch_windows = '<Tab>',
          reverse_switch_windows = '<S-Tab>',
          remove_file = 'd',
          add_file = '@',
          close = { '<Esc>', 'q' },
          close_from_input = { normal = { '<Esc>', 'q' }, insert = '<C-d>' },
        },
      },
      selection = {
        hint_display = 'none',
      },
      windows = {
        width = 40,
        sidebar_header = {
          rounded = false,
        },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'Kaiser-Yang/blink-cmp-avante' },
    opts = {
      sources = {
        default = { 'avante' },
        providers = { avante = { module = 'blink-cmp-avante', name = 'Avante' } },
      },
    },
  },
}
