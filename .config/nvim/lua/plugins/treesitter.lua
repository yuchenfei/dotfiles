-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
-- https://github.com/nvim-treesitter/nvim-treesitter-context
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects

return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function() require('config.treesitter') end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = function()
      local tsc = require('treesitter-context')
      Snacks.toggle({
        name = 'Treesitter Context',
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map('<leader>tt')
      return {
        max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
      }
    end,
    keys = {
      {
        '[c',
        function() require('treesitter-context').go_to_context(vim.v.count1) end,
        desc = 'Previous Context',
      },
    },
  },
}
