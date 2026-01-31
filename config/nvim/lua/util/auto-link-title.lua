-- References:
--  - https://github.com/zolrath/obsidian-auto-link-title

local M = {}

-- Basic URL check
local function is_url(text) return text:match('^https?://%S+$') ~= nil end

-- Check if URL is an image
local function is_image(url)
  local image_extensions = { 'png', 'jpg', 'jpeg', 'gif', 'bmp', 'svg', 'webp', 'ico' }
  local lower_url = url:lower()
  for _, ext in ipairs(image_extensions) do
    if lower_url:sub(-#ext - 1) == '.' .. ext then return true end
  end
  return false
end

-- Basic HTML entity decoder
local function decode_html(str)
  local entities = {
    ['&lt;'] = '<',
    ['&gt;'] = '>',
    ['&amp;'] = '&',
    ['&quot;'] = '"',
    ['&#39;'] = "'",
    ['&nbsp;'] = ' ',
  }
  return str:gsub('&%w+;', entities)
end

function M.paste_url()
  local url = vim.fn.getreg('+'):gsub('^%s*(.-)%s*$', '%1')

  -- If empty, not a URL, or is an image, paste normally
  if url == '' or not is_url(url) or is_image(url) then
    vim.cmd('normal! "+p')
    return
  end

  -- Generate a unique placeholder
  local id = os.time()
  local placeholder = 'Fetching Title ' .. id
  local markdown_link = string.format('[%s](%s)', placeholder, url)

  -- Insert placeholder at cursor
  vim.api.nvim_put({ markdown_link }, 'c', true, true)

  -- Async fetch title
  local cmd = { 'curl', '-s', '-L', '--max-time', '5', url }

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if not data then return end
      local result = table.concat(data, '')

      -- Normalize newlines for multi-line title tags
      result = result:gsub('[\r\n]', ' ')

      local title = result:match('<title[^>]*>(.-)</title>')

      if title then
        title = decode_html(title)
        -- Trim whitespace
        title = title:gsub('^%s*(.-)%s*$', '%1')
        -- Escape markdown characters (basic)
        title = title:gsub('([%[%]])', '\\%1')

        if title ~= '' then
          vim.schedule(function()
            local bufnr = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

            for i, line in ipairs(lines) do
              local s, e = line:find(placeholder, 1, true)
              if s then
                local new_line = line:sub(1, s - 1) .. title .. line:sub(e + 1)
                vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { new_line })
                return
              end
            end
          end)
        end
      end
    end,
    stdout_buffered = true,
  })
end

return M
