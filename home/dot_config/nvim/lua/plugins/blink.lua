-- https://github.com/Saghen/blink.cmp
-- https://github.com/rafamadriz/friendly-snippets
return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  ---@diagnostic disable: missing-fields
  opts = {
    keymap = {
      preset = "default",
      ["<PageDown>"] = { "scroll_documentation_down" },
      ["<PageUp>"] = { "scroll_documentation_up" },
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
