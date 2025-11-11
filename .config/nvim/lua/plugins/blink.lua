-- References:
-- - https://cmp.saghen.dev/installation
-- - https://github.com/rafamadriz/friendly-snippets
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/blink.lua

return {
  'saghen/blink.cmp',
  version = '1.*',
  dependencies = {
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
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
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', gap = 1 },
            -- { 'source_name' },
          },
          treesitter = { 'lsp' },
        },
        -- border = 'rounded', -- See `:h winborder`
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        -- window = { border = 'rounded' },
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
      default = { 'lsp', 'buffer', 'snippets', 'path', 'copilot' },
      per_filetype = {
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
        copilot = {
          name = 'Copilot',
          module = 'blink-copilot',
          score_offset = 100,
          async = true,
        },
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
      },
    },
  },
}
