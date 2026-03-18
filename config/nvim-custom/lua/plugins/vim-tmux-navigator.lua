-- https://github.com/christoomey/vim-tmux-navigator

return {
  'christoomey/vim-tmux-navigator',
  event = 'VeryLazy',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
    -- { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_save_on_switch = 2 -- 1: current buffer 2: all buffers
    vim.g.tmux_navigator_disable_when_zoomed = 1
    -- vim.g.tmux_navigator_preserve_zoom = 1
  end,
}
