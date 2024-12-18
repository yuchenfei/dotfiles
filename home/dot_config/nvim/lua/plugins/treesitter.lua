return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<c-[>", desc = "Decrement Selection", mode = "x" },
        { "<c-]>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<c-space>", false },
      { "<bs>", mode = "x", false },
      { "<c-]>", desc = "Increment Selection" },
      { "<c-[>", desc = "Decrement Selection", mode = "x" },
    },
    opts = {
      highlight = {
        disable = function()
          -- check if 'filetype' option includes 'chezmoitmpl'
          if string.find(vim.bo.filetype, "chezmoitmpl") then
            return true
          end
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-]>",
          node_incremental = "<c-]>",
          scope_incremental = false,
          node_decremental = "<c-[>",
        },
      },
    },
  },
}
