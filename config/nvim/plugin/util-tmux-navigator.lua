vim.g.tmux_navigator_no_mappings = 1
vim.g.tmux_navigator_save_on_switch = 2 -- 1: current buffer 2: all buffers
vim.g.tmux_navigator_disable_when_zoomed = 1

vim.pack.add({ 'https://github.com/christoomey/vim-tmux-navigator' })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Go to Left Window or Pane' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Go to Lower Window or Pane' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Go to Upper Window or Pane' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Go to Right Window or Pane' })
