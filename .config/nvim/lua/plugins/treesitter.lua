-- References:
--  - https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
--  - https://github.com/nvim-treesitter/nvim-treesitter-textobjects
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua
--  - https://github.com/nvim-treesitter/nvim-treesitter-context

--- @type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function() require('config.treesitter') end,
  },
  {
    -- Support @function.outer, @class.outer, etc. textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    event = 'VeryLazy',
    opts = {
      move = {
        set_jumps = true,
      },
    },
    keys = function()
      -- stylua: ignore
      local key_opts = {
        goto_next_start     = {[']f'] = '@function.outer', [']c'] = '@class.outer', [']a'] = '@parameter.inner',},
        goto_next_end       = {[']F'] = '@function.outer', [']C'] = '@class.outer', [']A'] = '@parameter.inner',},
        goto_previous_start = {['[f'] = '@function.outer', ['[c'] = '@class.outer', ['[a'] = '@parameter.inner',},
        goto_previous_end   = {['[F'] = '@function.outer', ['[C'] = '@class.outer', ['[A'] = '@parameter.inner',},
      }

      local keys = {}
      for method, keymaps in pairs(key_opts) do
        for key, query in pairs(keymaps) do
          local queries = type(query) == 'table' and query or { query }
          local parts = {}
          for _, q in ipairs(queries) do
            local part = q:gsub('@', ''):gsub('%..*', '')
            part = part:sub(1, 1):upper() .. part:sub(2)
            table.insert(parts, part)
          end
          local desc = table.concat(parts, ' or ')
          desc = 'TS: ' .. (key:sub(1, 1) == '[' and 'Prev ' or 'Next ') .. desc
          desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and ' End' or ' Start')
          table.insert(keys, {
            key,
            function() require('nvim-treesitter-textobjects.move')[method](query, 'textobjects') end,
            desc = desc,
          })
        end
      end
      return keys
    end,
  },
  {
    -- Show code context (e.g., function/class name) at the top of the window while scrolling
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
        '[x',
        function() require('treesitter-context').go_to_context(vim.v.count1) end,
        desc = 'TS: Previous Context',
      },
    },
  },
}
