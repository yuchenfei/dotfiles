-- https://github.com/epwalsh/obsidian.nvim
return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian/Notes/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian/Notes/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Documents/Obsidian/Notes/",
        },
      },
      completion = {
        nvim_cmp = false,
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)

      -- HACK: fix error: disable completion.nvim_cmp option, manually register sources
      -- https://github.com/epwalsh/obsidian.nvim/issues/770#issuecomment-2516398527
      local cmp = require("cmp")
      cmp.register_source("obsidian", require("cmp_obsidian").new())
      cmp.register_source("obsidian_new", require("cmp_obsidian_new").new())
      cmp.register_source("obsidian_tags", require("cmp_obsidian_tags").new())
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "obsidian", "obsidian_new", "obsidian_tags" },
        providers = {
          obsidian = {
            name = "obsidian",
            module = "blink.compat.source",
          },
          obsidian_new = {
            name = "obsidian_new",
            module = "blink.compat.source",
          },
          obsidian_tags = {
            name = "obsidian_tags",
            module = "blink.compat.source",
          },
        },
      },
    },
  },
}
