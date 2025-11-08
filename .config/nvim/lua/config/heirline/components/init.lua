local function lazy_require(name)
  return function() return require('config.heirline.components.' .. name) end
end

local M = {
  Space = function() return { provider = ' ' } end,
  Align = function() return { provider = '%=' } end,
  Mode = lazy_require('mode'),
  Ruler = lazy_require('ruler'),
  ScrollBar = lazy_require('scroll-bar'),
  FileName = lazy_require('file-name'),
  FileType = lazy_require('file-type'),
  FileEncoding = lazy_require('file-encoding'),
  FileFormat = lazy_require('file-format'),
  FileSize = lazy_require('file-size'),
  FileLastModified = lazy_require('file-last-modified'),
  LSPActive = lazy_require('lsp-active'),
  Diagnostics = lazy_require('diagnostics'),
  Git = lazy_require('git'),
  SearchCount = lazy_require('search-count'),
  MacroRec = lazy_require('macro-rec'),
  ShowCmd = lazy_require('show-cmd'),
}

return M
