local M = {}

function M.reload_modules(prefix)
  for module_name in pairs(package.loaded) do
    if module_name:match('^' .. prefix) then package.loaded[module_name] = nil end
  end
end

return M
