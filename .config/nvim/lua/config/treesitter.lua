-- See `:help nvim-treesitter`
-- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`

---@diagnostic disable-next-line: redundant-parameter
require('nvim-treesitter').setup({
  ensure_installed = {
    'bash',
    'c',
    'diff',
    'html',
    'lua',
    'luadoc',
    'markdown',
    'markdown_inline',
    'nix',
    'query',
    'vim',
    'vimdoc',
  },
  auto_install = true,
  highlight = {
    enable = true,
    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
    --  If you are experiencing weird indenting issues, add the language to
    --  the list of additional_vim_regex_highlighting and disabled languages for indent.
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
})
