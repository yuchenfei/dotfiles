-- Plugins:
--  - https://github.com/saghen/blink.cmp
--  - https://github.com/archie-judd/blink-cmp-words
--  - https://github.com/folke/lazydev.nvim
--
-- References:
--  - https://cmp.saghen.dev/installation
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/blink.lua

---@type LazySpec
return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'archie-judd/blink-cmp-words',
    'folke/lazydev.nvim',
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      ['<C-space>'] = false,
      ['<M-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<PageDown>'] = { 'scroll_documentation_down', 'fallback' },
      ['<PageUp>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-u>'] = { function(cmp) return cmp.select_prev({ count = 5 }) end, 'fallback' },
      ['<C-d>'] = { function(cmp) return cmp.select_next({ count = 5 }) end, 'fallback' },
    },
    completion = {
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'kind' },
            -- { 'source_name' },
          },
          treesitter = { 'lsp' },
        },
        -- border = 'rounded', -- See `:h winborder`
        scrollbar = false,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          -- border = 'rounded',
          scrollbar = false,
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = {
      enabled = true,
      -- window = { border = 'rounded' },
    },
    cmdline = {
      keymap = {
        ['<C-space>'] = false,
        ['<M-space>'] = { 'show', 'fallback' },
        ['<Right>'] = false,
        ['<Left>'] = false,
        ['<C-u>'] = { function(cmp) return cmp.select_prev({ count = 5 }) end, 'fallback' },
        ['<C-d>'] = { function(cmp) return cmp.select_next({ count = 5 }) end, 'fallback' },
      },
      completion = {
        menu = {
          auto_show = function() return vim.fn.getcmdtype() == ':' end,
        },
      },
    },
    sources = {
      default = { 'lsp', 'path', 'buffer', 'snippets' },
      per_filetype = {
        text = { 'thesaurus', 'dictionary' },
        markdown = { inherit_defaults = true, 'thesaurus', 'dictionary' },
        lua = { inherit_defaults = true, 'lazydev' },
      },
      providers = {
        -- Buffer completion from all open buffers
        -- - https://cmp.saghen.dev/recipes#buffer-completion-from-all-open-buffers
        buffer = {
          opts = {
            -- get all buffers, even ones like neo-tree
            -- get_bufnrs = vim.api.nvim_list_bufs
            -- or (recommended) filter to only "normal" buffers
            get_bufnrs = function()
              return vim.tbl_filter(
                function(bufnr) return vim.bo[bufnr].buftype == '' end,
                vim.api.nvim_list_bufs()
              )
            end,
          },
        },
        snippets = {
          should_show_items = function(ctx) -- avoid triggering snippets after . " ' chars.
            return ctx.trigger.initial_kind ~= 'trigger_character'
          end,
          score_offset = 20,
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        -- Use the thesaurus source
        thesaurus = {
          name = 'blink-cmp-words',
          module = 'blink-cmp-words.thesaurus',
          -- All available options
          opts = {
            -- A score offset applied to returned items.
            -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
            score_offset = 0,

            -- Default pointers define the lexical relations listed under each definition,
            -- see Pointer Symbols below.
            -- Default is as below ("antonyms", "similar to" and "also see").
            definition_pointers = { '!', '&', '^' },

            -- The pointers that are considered similar words when using the thesaurus,
            -- see Pointer Symbols below.
            -- Default is as below ("similar to", "also see" }
            similarity_pointers = { '&', '^' },

            -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
            -- 2 is similar words of similar words, etc. Increasing this may slow results.
            similarity_depth = 2,
          },
        },
        -- Use the dictionary source
        dictionary = {
          name = 'blink-cmp-words',
          module = 'blink-cmp-words.dictionary',
          -- All available options
          opts = {
            -- The number of characters required to trigger completion.
            -- Set this higher if completion is slow, 3 is default.
            dictionary_search_threshold = 3,

            -- See above
            score_offset = 0,

            -- See above
            definition_pointers = { '!', '&', '^' },
          },
        },
      },
    },
  },
}
