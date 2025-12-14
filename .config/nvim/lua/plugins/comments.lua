-- Improves comment syntax, lets Neovim handle multiple
-- types of comments for a single language, and relaxes rules
-- for uncommenting.
--
-- References:
--  - https://github.com/folke/ts-comments.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
--
-- Similar plugins:
--  - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-comment.md
--  - https://github.com/numToStr/Comment.nvim

return {
  -- Improves comment syntax, lets Neovim handle multiple
  -- types of comments for a single language, and relaxes rules
  -- for uncommenting.
  {
    'folke/ts-comments.nvim',
    event = 'VeryLazy',
  },
  -- {
  --   'nvim-mini/mini.comment',
  --   event = 'VeryLazy',
  -- },
}
