-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/copilotlsp-nvim/copilot-lsp

return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  build = ':Copilot auth',
  event = 'InsertEnter',
  opts = {
    panel = { enabled = false },
    suggestion = {
      enabled = true,
      auto_trigger = false,
      hide_during_completion = true,
      keymap = {
        accept = '<M-l>',
        accept_word = '<M-w>',
        accept_line = '<M-h>',
        next = '<M-]>',
        prev = '<M-[>',
        dismiss = '<C-]>',
      },
    },
    filetypes = {
      markdown = true,
      help = true,
    },
  },
}
