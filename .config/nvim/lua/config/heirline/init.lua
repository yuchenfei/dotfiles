-- References:
--  - https://github.com/rebelot/heirline.nvim
--  - https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md
--
-- Other Plugins:
--  - https://github.com/linrongbin16/lsp-progress.nvim

local conditions = require('config.heirline.conditions')
local utils = require('heirline.utils')

-- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/palettes/mocha.lua
local palette = require('catppuccin.palettes').get_palette('mocha')

local colors = {
  diag_error = utils.get_highlight('DiagnosticError').fg,
  diag_warn = utils.get_highlight('DiagnosticWarn').fg,
  diag_info = utils.get_highlight('DiagnosticInfo').fg,
  diag_hint = utils.get_highlight('DiagnosticHint').fg,
  git_add = utils.get_highlight('GitsignsAdd').fg,
  git_del = utils.get_highlight('GitsignsDelete').fg,
  git_change = utils.get_highlight('GitsignsChange').fg,
}

colors = vim.tbl_extend('force', palette, colors)

require('util').reload_modules('config.heirline.components')
local c = require('config.heirline.components')

require('heirline').setup({
  opts = {
    colors = colors,
  },
  ---@diagnostic disable-next-line: missing-fields
  statusline = {
    hl = { bg = 'base' },
    {
      c.Mode,
      {
        utils.surround({ ' ', ' ' }, nil, c.FileNameBlock),
        hl = { bg = 'surface1' },
      },
      {
        condition = conditions.is_git_repo,
        utils.surround({ ' ', ' ' }, nil, {
          c.GitBranch,
          c.Space,
          c.GitDiff,
        }),
        hl = { bg = 'surface0' },
      },
      c.Diagnostics,
      c.Space,
      c.SearchCount,
    },
    c.Align,
    {
      c.MacroRec,
      c.ShowCmd,
    },
    c.Align,
    { provider = '%<' }, -- this means that the statusline is cut here when there's not enough space
    -- { c.LSPActive, c.Space },
    {
      c.FileSize,
      c.Space,
      c.FileEncoding,
      c.Space,
      c.FileFormat,
      c.Space,
      c.FileType,
      c.Space,
    },
    {
      c.Ruler,
      c.ScrollBar,
    },
  },
})
