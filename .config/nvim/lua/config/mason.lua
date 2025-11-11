-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason-tool-installer').setup({
  ensure_installed = {
    -- Lua
    'lua_ls',
    'stylua',
  },
})
