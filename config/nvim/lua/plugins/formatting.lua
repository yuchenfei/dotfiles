-- https://github.com/stevearc/conform.nvim

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["*"] = { "injected" },
      },
    },
  },
}
