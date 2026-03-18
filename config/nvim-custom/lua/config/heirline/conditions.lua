-- Refferences:
--  - https://github.com/AstroNvim/astroui/blob/main/lua/astroui/status/condition.lua

local conditions = require('heirline.conditions')

function conditions.is_file(bufnr)
  if type(bufnr) == 'table' then bufnr = bufnr.bufnr end
  if not bufnr then bufnr = 0 end
  return vim.bo[bufnr].buftype == ''
end

return conditions
