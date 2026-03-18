-- Plugins:
-- - https://github.com/rafamadriz/friendly-snippets
-- - https://github.com/L3MON4D3/LuaSnip
--
-- References:
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/luasnip.lua

---@type LazySpec
return {
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    lazy = true,
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function() require('luasnip.loaders.from_vscode').lazy_load() end,
      },
    },
    -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#config-options
    opts = function(_, opts)
      require('config.luasnip')
      return opts
    end,
  },
  {
    'saghen/blink.cmp',
    opts = {
      snippets = {
        preset = 'luasnip',
      },
    },
  },
}
