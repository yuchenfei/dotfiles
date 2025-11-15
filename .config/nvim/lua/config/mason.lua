-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason-tool-installer').setup({
  ensure_installed = {
    'tree-sitter-cli',
    'prettier',
    -- Lua
    'lua_ls',
    'stylua',
    -- Nix
    'nil_ls',
    -- Markdown
    'marksman',
    'markdownlint-cli2',
  },
})
