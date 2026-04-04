-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/ltex.lua
-- https://valentjn.github.io/ltex/index.html

---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          language = "en-US,zh-CN",
        },
      },
    },
  },
}
