local FileFormat = {
  provider = function()
    local fmt = vim.bo.fileformat
    -- return fmt ~= 'unix' and fmt:upper()
    return fmt:upper()
  end,
}

return FileFormat
