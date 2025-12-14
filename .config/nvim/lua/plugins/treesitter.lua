-- ── Plugins ─────────────────────────────────────────────────────────
-- - https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md
-- - https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/main
-- - https://github.com/nvim-treesitter/nvim-treesitter-context
--
-- ── References ──────────────────────────────────────────────────────
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/treesitter.lua

--- @type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    opts_extend = { 'ensure_installed' },
    opts = {
      -- Directory to install parsers and queries to
      install_dir = vim.fn.stdpath('data') .. '/site',
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'latex',
        'query',
        'toml',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
    },
    config = function(_, opts)
      local TS = require('nvim-treesitter')
      TS.setup(opts)

      local installed = TS.get_installed()
      local install = vim.tbl_filter(
        function(lang) return not vim.tbl_contains(installed, lang) end,
        opts.ensure_installed or {}
      )
      if #install > 0 then TS.install(install, { summary = true }) end

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
        callback = function(args)
          local filetype = args.match
          if filetype == '' then return end

          local lang = vim.treesitter.language.get_lang(filetype)

          if vim.tbl_contains(TS.get_installed(), lang) then
            pcall(vim.treesitter.start, args.buf)
          end
        end,
      })
    end,
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
