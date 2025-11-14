---@type LazySpec
return {
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.icons',
    },
    -- Also config in opts.file_types
    ft = { 'markdown', 'Avante' },
    config = function()
      require('config.markdown')
      Snacks.toggle({
        name = 'Render Markdown',
        get = require('render-markdown').get,
        set = require('render-markdown').set,
      }):map('<leader>tm')
    end,
  },
  -- https://github.com/bullets-vim/bullets.vim
  {
    'bullets-vim/bullets.vim',
    ft = { 'markdown' },
    init = function() vim.g.bullets_pad_right = 0 end,
  },
}
