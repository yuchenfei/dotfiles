-- References:
--  - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-icons.md
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua

return {
  'nvim-mini/mini.icons',
  lazy = true,
  opts = {},
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
}
