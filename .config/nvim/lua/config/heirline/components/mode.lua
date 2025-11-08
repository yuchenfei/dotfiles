-- References:
--  - https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#crash-course-the-vimode
--  - https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua
--  - https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/lualine.lua
--  - https://github.com/catppuccin/catppuccin#-palette

local Mode = {
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

return Mode
