return {
  "stevearc/conform.nvim",
  keys = {
    { "<leader>cF", mode = { "n", "v" }, false },
  },
  opts = {
    -- log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      ["*"] = { "injected" }, -- enables injected-lang formatting for all filetypes
    },
    formatters = {
      -- injected = { options = { ignore_errors = false } },
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      prettier = {
        prepend_args = { "--single-quote" },
      },
      sqlfluff = {
        require_cwd = false, -- default enable for injected-lang formatters
      },
    },
  },
}
