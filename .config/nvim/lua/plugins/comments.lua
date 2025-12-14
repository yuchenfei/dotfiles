-- ── Plugins ─────────────────────────────────────────────────────────
-- - https://github.com/folke/ts-comments.nvim
--   Similar Plugins:
--     - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-comment.md
--     - https://github.com/numToStr/Comment.nvim
-- - https://github.com/LudoPinelli/comment-box.nvim
--
-- ── References ──────────────────────────────────────────────────────
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/mini-comment.lua

return {
  -- ╓
  -- ║ Improves comment syntax, lets Neovim handle multip
  -- ║ types of comments for a single language, and relaxes rule
  -- ║ for uncommenting.
  -- ╙
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
  },
  {
    'LudoPinelli/comment-box.nvim',
    event = 'VeryLazy',
    keys = {
      { '<Leader>cb', '<Cmd>CBccbox<CR>', mode = { 'n', 'v' }, desc = 'Box Title' },
      { '<Leader>ct', '<Cmd>CBllline<CR>', mode = { 'n', 'v' }, desc = 'Titled Line' },
      { '<Leader>cl', '<Cmd>CBline<CR>', desc = 'Simple Line' },
      { '<Leader>cm', '<Cmd>CBllbox14<CR>', mode = { 'n', 'v' }, desc = 'Marked' },
      { '<Leader>cq', '<Cmd>CBllbox13<CR>', mode = { 'n', 'v' }, desc = 'Quote' },
      { '<Leader>cd', '<Cmd>CBd<CR>', mode = { 'n', 'v' }, desc = 'Remove' },
      { '<Leader>cy', '<Cmd>CBy<CR>', mode = { 'n', 'v' }, desc = 'Yank Content' },
      { '<Leader>cc', '<Cmd>CBcatalog<CR>', desc = 'Show all types' },
    },
    opts = function()
      require('which-key').add({ '<leader>c', group = 'Comment Box', icon = '󰃔' })
    end,
  },
}
