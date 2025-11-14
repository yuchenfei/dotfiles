-- References:
--  - https://github.com/yetone/avante.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/ai/avante.lua

return {
  'yetone/avante.nvim',
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has('win32') ~= 0
      and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
    or 'make',
  event = 'VeryLazy',
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = 'copilot',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-mini/mini.icons',
    'zbirenbaum/copilot.lua',
    'HakonHarnes/img-clip.nvim',
    'MeanderingProgrammer/render-markdown.nvim',
  },
}
