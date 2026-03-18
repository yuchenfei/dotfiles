-- https://github.com/folke/sidekick.nvim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/ai/sidekick.lua

---@type LazySpec
return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        win = {
          split = {
            width = 60,
          },
          keys = {
            prompt = false,
          },
        },
        tools = {
          gac = { cmd = { "gac", "-os" } },
        },
      },
    },
    keys = {
      -- kitty tmux environment has a weird interaction with <c-.> so disable it and use <m-cr> instead
      {
        "<c-.>",
        false,
        mode = { "n", "t", "i", "x" },
      },
      {
        "<m-cr>",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>ga",
        function()
          require("sidekick.cli").toggle({ name = "gac", focus = true })
        end,
        desc = "Sidekick Auto Commit",
      },
    },
  },
}
