-- References:
-- - https://www.reddit.com/r/vim/comments/139fn2b/plugin_paste_markdown_link_with_title/
-- - https://stojanow.com/til/auto-link-url-title-in-neovim/

local M = {}

function M.insert_markdown_url()
  local url = vim.fn.getreg('+')
  if url == '' then return end

  local handle = io.popen('curl -s ' .. url)
  if not handle then return end
  local result = handle:read('*a')
  handle:close()

  local title = result:match('<title>(.-)</title>')

  local markdown_url = '[' .. title .. '](' .. url .. ')'

  vim.api.nvim_put({ markdown_url }, '', true, true)
end

return M
