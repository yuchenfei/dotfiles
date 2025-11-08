local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.hl, _ = MiniIcons.get('file', 'file.' .. extension)
  end,
  provider = function(self) return self.icon and (self.icon .. ' ') end,
}

local FileName = {
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ':.') -- see :h filename-modifers
    if filename == '' then return '[No Name]' end
    if not conditions.width_percent_below(#filename, 0.25) then
      filename = vim.fn.pathshorten(filename)
    end
    return filename
  end,
  hl = { fg = utils.get_highlight('Directory').fg },
}

local FileFlags = {
  {
    condition = function() return vim.bo.modified end,
    provider = '[+]',
    hl = { fg = 'green' },
  },
  {
    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
    provider = '',
    hl = { fg = 'orange' },
  },
}

local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = 'cyan', bold = true, force = true }
    end
  end,
}

local FileNameBlock = {
  init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
}

FileNameBlock = utils.insert(
  FileNameBlock,
  FileIcon,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  FileFlags,
  { provider = '%<' } -- this means that the statusline is cut here when there's not enough space
)

return FileNameBlock
