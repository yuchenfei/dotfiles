-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md

local TS = require('nvim-treesitter')

TS.setup({
  -- Directory to install parsers and queries to
  install_dir = vim.fn.stdpath('data') .. '/site',
})

local ensure_installed = {
  'bash',
  'c',
  'diff',
  'html',
  'json',
  'jsonc',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nix',
  'python',
  'query',
  'toml',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

local installed = TS.get_installed()
local install = vim.tbl_filter(
  function(lang) return not vim.tbl_contains(installed, lang) end,
  ensure_installed
)
if #install > 0 then TS.install(install, { summary = true }) end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
  callback = function(args)
    local filetype = args.match

    if filetype == '' then return end

    local lang = vim.treesitter.language.get_lang(filetype)

    if vim.tbl_contains(TS.get_installed(), lang) then pcall(vim.treesitter.start, args.buf) end
  end,
})
