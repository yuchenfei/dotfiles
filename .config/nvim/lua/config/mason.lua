-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim

require('mason-tool-installer').setup({
  run_on_start = true,
  ensure_installed = {
    'tree-sitter-cli',
    'html',
    'jsonls',
    'prettier',
    -- Lua
    'lua_ls',
    'stylua',
    -- Nix
    'nil_ls',
    -- Markdown
    'marksman',
    'markdownlint-cli2', -- https://github.com/DavidAnson/markdownlint-cli2
    -- Python
    'basedpyright',
    'pyrefly',
    'ruff', -- https://docs.astral.sh/ruff/editors/setup/
    -- TypeScript/JavaScript
    'vtsls',
    'biome',
  },
})
