local M = {}

function M.reload_modules(prefix)
  for module_name in pairs(package.loaded) do
    if module_name:match('^' .. prefix) then package.loaded[module_name] = nil end
  end
end

-- Function to copy file path to clipboard
function M.copy_filepath_to_clipboard()
  local filePath = vim.fn.expand('%:~') -- Gets the file path relative to the home directory
  vim.fn.setreg('+', filePath) -- Copy the file path to the clipboard register
  vim.notify('Path copied to clipboard:\n' .. filePath, vim.log.levels.INFO)
end

return M
