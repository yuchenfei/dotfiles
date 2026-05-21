-- https://cmp.saghen.dev/configuration/reference.html

---@type blink.cmp.Config
local opts = {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = 'default' },

  snippets = { preset = 'luasnip' },

  completion = {
    menu = {
      scrollbar = false,
      draw = {
        treesitter = { 'lsp' },
        columns = {
          { 'kind_icon' },
          { 'label', 'label_description', gap = 1 },
          { 'kind' },
          -- { 'source_name' },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = { border = 'none', scrollbar = false },
    },
    ghost_text = { enabled = true },
  },

  -- signature = {
  --   enabled = true,
  -- },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    per_filetype = {
      text = { 'dictionary' },
      markdown = { 'thesaurus' },
      lua = { inherit_defaults = true, 'lazydev' },
    },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
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

  cmdline = {
    keymap = {
      ['<Right>'] = false,
      ['<Left>'] = false,
    },
    completion = {
      menu = {
        auto_show = function(_) return vim.fn.getcmdtype() == ':' end,
      },
    },
  },
}

local function completion_setup()
  vim.pack.add({
    { src = 'https://github.com/L3MON4D3/LuaSnip', version = vim.version.range('2.*') },
    { src = 'https://github.com/archie-judd/blink-cmp-words' },
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1.*') },
  })
  require('luasnip').setup({})
  require('blink.cmp').setup(opts)
end

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = vim.api.nvim_create_augroup('completion-setup', { clear = true }),
  once = true,
  callback = function() completion_setup() end,
})
