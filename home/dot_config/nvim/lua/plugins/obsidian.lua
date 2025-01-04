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
      disable_frontmatter = true,
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        compat = { "obsidian", "obsidian_new", "obsidian_tags" },
      },
    },
  },
}
