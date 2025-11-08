-- Reference:
--  - https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#cursor-position-ruler-and-scrollbar
--  - https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/components/location.lua

local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- provider = '%7(%l/%3L%):%2c %P',
  provider = ' %3l:%-2c %P ',
  hl = { fg = 'base', bg = 'blue', bold = true },
}

return Ruler
