-- References:
--  - https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md
--  - https://github.com/nvim-lualine/lualine.nvim/tree/master/lua/lualine/components
--
-- Colors:
--  - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/lualine.lua
--  - https://github.com/catppuccin/catppuccin#-palette

local conditions = require('config.heirline.conditions')
local utils = require('heirline.utils')

local M = {
  Space = { provider = ' ' },
  Align = { provider = '%=' },
}

M.Mode = {
  init = function(self)
    -- :h mode()
    -- self.mode = vim.fn.mode(1)
    self.mode = vim.api.nvim_get_mode().mode
  end,
  static = {
    -- stylua: ignore
    mode_names = {
      n         = 'NORMAL',
      no        = 'O-PENDING',
      nov       = 'O-PENDING',
      noV       = 'O-PENDING',
      ['no\22'] = 'O-PENDING',
      niI       = 'NORMAL',
      niR       = 'NORMAL',
      niV       = 'NORMAL',
      nt        = 'NORMAL',
      v         = 'VISUAL',
      vs        = 'VISUAL',
      V         = 'V-LINE',
      Vs        = 'V-LINE',
      ['\22']   = 'V-BLOCK',
      ['\22s']  = 'V-BLOCK',
      s         = 'SELECT',
      S         = 'S-LINE',
      ['\19']   = 'S-BLOCK',
      i         = 'INSERT',
      ic        = 'INSERT',
      ix        = 'INSERT',
      R         = 'REPLACE',
      Rc        = 'REPLACE',
      Rx        = 'REPLACE',
      Rv        = 'V-REPLACE',
      Rvc       = 'V-REPLACE',
      Rvx       = 'V-REPLACE',
      c         = 'COMMAND',
      cv        = 'Ex',
      r         = 'REPLACE',
      rm        = 'MORE',
      ['r?']    = 'CONFIRM',
      ['!']     = 'SHELL',
      t         = 'TERMINAL',
    },
    -- stylua: ignore
    mode_colors = {
      n       = 'blue',
      i       = 'green',
      v       = 'mauve',
      V       = 'mauve',
      ['\22'] = 'mauve',
      c       = 'peach',
      s       = 'pink',
      S       = 'pink',
      ['\19'] = 'pink',
      R       = 'red',
      r       = 'red',
      ['!']   = 'red',
      t       = 'green',
    },
  },
  provider = function(self) return ' %1(' .. self.mode_names[self.mode] .. '%) ' end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = 'base', bg = self.mode_colors[mode], bold = true }
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function() vim.cmd('redrawstatus') end),
  },
}

M.FileIcon = {
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e') -- see :h filename-modifers
    self.icon, self.hl, _ = MiniIcons.get('file', 'file.' .. extension)
  end,
  provider = function(self) return self.icon and (self.icon .. ' ') end,
}

M.FileName = {
  init = function(self) self.lfilename = vim.fn.fnamemodify(self.filename, ':.') end,
  provider = function(self)
    if self.lfilename == '' then return vim.bo.filetype end
    if not conditions.width_percent_below(#self.lfilename, 0.25) then
      return vim.fn.pathshorten(self.lfilename)
    end
    return self.lfilename
  end,
  hl = function(self)
    return {
      fg = self.lfilename == '' and 'text' or (vim.bo.modified and 'yellow' or 'blue'),
      italic = vim.bo.modified,
      underline = not vim.bo.modifiable or vim.bo.readonly,
    }
  end,
}

M.FileNameBlock = {
  init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
  M.FileIcon,
  M.FileName,
}

M.FileSize = {
  provider = function()
    local suffix = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then return fsize .. suffix[1] end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format('%.2g%s', fsize / math.pow(1024, i), suffix[i + 1])
  end,
}

M.FileLastModified = {
  provider = function()
    local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
    return (ftime > 0) and os.date('%c', ftime)
  end,
}

M.FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc -- :h 'enc'
    -- return enc ~= 'utf-8' and enc:upper()
    return enc
  end,
}

M.FileFormat = {
  static = {
    fmt_icons = {
      DOS = '', -- CRLF
      UNIX = '', -- LF
      MAC = '', -- CR
    },
  },
  provider = function(self)
    local fmt = vim.bo.fileformat -- dos, unix, mac
    -- return fmt ~= 'unix' and fmt:upper()
    return self.fmt_icons[fmt:upper()] or fmt
  end,
}

M.FileType = {
  provider = function() return vim.bo.filetype end,
  hl = { fg = utils.get_highlight('Type').fg, bold = true },
}

M.GitBranch = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0
      or self.status_dict.removed ~= 0
      or self.status_dict.changed ~= 0
  end,
  provider = function(self) return ' ' .. self.status_dict.head end,
  hl = { fg = 'blue', bold = true },
}

M.GitDiff = {
  condition = conditions.is_git_repo,
  init = function(self)
    local status_dict = vim.b.gitsigns_status_dict
    self.added = status_dict.added or 0
    self.changed = status_dict.changed or 0
    self.removed = status_dict.removed or 0
  end,
  {
    provider = function(self) return self.added > 0 and ('+' .. self.added) end,
    hl = { fg = 'git_add' },
  },
  {
    provider = function(self)
      local show = self.added > 0 and self.changed > 0
      return show and ' ' or ''
    end,
  },
  {
    provider = function(self) return self.changed > 0 and ('~' .. self.changed) end,
    hl = { fg = 'git_change' },
  },
  {
    provider = function(self)
      local show = self.changed > 0 and self.removed > 0
      return show and ' ' or ''
    end,
  },
  {
    provider = function(self) return self.removed > 0 and ('-' .. self.removed) end,
    hl = { fg = 'git_del' },
  },
}

M.Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.ERROR],
    warn_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.WARN],
    info_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.INFO],
    hint_icon = vim.diagnostic.config()['signs']['text'][vim.diagnostic.severity.HINT],
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
  {
    provider = function(self) return self.errors > 0 and (self.error_icon .. self.errors .. ' ') end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ') end,
    hl = { fg = 'diag_warn' },
  },
  {
    provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. ' ') end,
    hl = { fg = 'diag_info' },
  },
  {
    provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints) end,
    hl = { fg = 'diag_hint' },
  },
}

M.LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return ' [' .. table.concat(names, ' ') .. ']'
  end,
  hl = { fg = 'green' },
}

M.SearchCount = {
  condition = function() return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0 end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then self.search = search end
  end,
  provider = function(self)
    local search = self.search
    return string.format(' [%d/%d]', search.current, math.min(search.total, search.maxcount))
  end,
  hl = { fg = 'sky' },
}

vim.opt.showcmdloc = 'statusline'
M.ShowCmd = {
  condition = function() return vim.o.cmdheight == 0 end,
  provider = ':%3.5(%S%)',
}

M.MacroRec = {
  condition = function() return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0 end,
  provider = ' ',
  hl = { fg = 'orange', bold = true },
  utils.surround({ '[', ']' }, nil, {
    provider = function() return vim.fn.reg_recording() end,
    hl = { fg = 'green', bold = true },
  }),
  update = {
    'RecordingEnter',
    'RecordingLeave',
  },
}

M.Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- provider = '%7(%l/%3L%):%2c %P',
  provider = ' %2l:%-2c %P ',
  hl = { fg = 'base', bg = 'blue', bold = true },
}

M.ScrollBar = {
  static = {
    -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'blue' },
}

return M
