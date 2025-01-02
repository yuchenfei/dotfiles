-- https://github.com/Saghen/blink.cmp
-- https://github.com/rafamadriz/friendly-snippets
return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  ---@diagnostic disable: missing-fields
  opts = {
    keymap = {
      ["<C-space>"] = {},
      ["<M-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
      ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
    },
    completion = {
      list = {
        selection = "preselect",
      },
      menu = {
        border = "rounded",
      },
      documentation = {
        window = {
          border = "rounded",
        },
      },
    },
    sources = {
      providers = {
        snippets = {
          opts = {
            friendly_snippets = true,
            extended_filetypes = {},
            ignored_filetypes = {},
          },
          score_offset = 0,
        },
      },
    },
  },
}
