-- Similar plugins:
--  - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-pairs.md
--    - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
--  - https://github.com/windwp/nvim-autopairs
--  - https://github.com/altermo/ultimate-autopair.nvim

return {
  'altermo/ultimate-autopair.nvim',
  branch = 'v0.6', --recommended as each new version will have breaking changes
  event = { 'InsertEnter', 'CmdlineEnter' },
  -- See `:help ultimate-autopair-default-config`
  opts = {},
}
