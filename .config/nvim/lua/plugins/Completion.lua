-- References:
-- - https://cmp.saghen.dev/installation
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/blink.lua
--
-- Plugins:
-- - https://github.com/saghen/blink.cmp
-- - https://github.com/rafamadriz/friendly-snippets
-- - https://github.com/archie-judd/blink-cmp-words
-- - https://github.com/fang2hou/blink-copilot
-- - https://github.com/folke/lazydev.nvim

--- @type LazySpec
return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'archie-judd/blink-cmp-words',
    'fang2hou/blink-copilot',
    'folke/lazydev.nvim',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  config = function() require('config.Completion') end,
}
