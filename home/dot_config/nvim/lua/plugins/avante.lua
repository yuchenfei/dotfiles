-- https://github.com/yetone/avante.nvim
-- https://github.com/AstroNvim/astrocommunity/blob/b8efe23b044da9c271ca87159fa148daa908008c/lua/astrocommunity/completion/avante-nvim/init.lua
-- https://github.com/LazyVim/LazyVim/pull/4440
local prefix = "<Leader>a"
return {
  {
    "yetone/avante.nvim",
    version = false,
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
    event = "VeryLazy",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    opts = {
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      copilot = {
        model = "claude-3.5-sonnet", -- gpt-4o-2024-08-06 or claude-3.5-sonnet
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 4096,
      },
      file_selector = {
        provider = "fzf",
      },
      mappings = {
        ask = prefix .. "<CR>",
        edit = prefix .. "e",
        refresh = prefix .. "r",
        focus = prefix .. "f",
        toggle = {
          default = prefix .. "t",
          debug = prefix .. "d",
          hint = prefix .. "h",
          suggestion = prefix .. "s",
          repomap = prefix .. "R",
        },
      },
    },
    specs = {
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {
        "saghen/blink.cmp",
        opts = {
          sources = {
            compat = {
              "avante_commands",
              "avante_mentions",
              "avante_files",
            },
          },
        },
      },
      {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
          opts.right = opts.right or {}
          table.insert(opts.right, 1, {
            ft = "AvanteInput",
            title = "Avante (Input)",
            size = { height = 9 },
          })
          table.insert(opts.right, 1, {
            ft = "AvanteSelectedFiles",
            title = "Avante (Selected Files)",
            size = { height = 3 },
          })
          table.insert(opts.right, 1, {
            ft = "Avante",
            title = "Avante",
            size = { width = 50 },
          })
        end,
      },
    },
  },
}
