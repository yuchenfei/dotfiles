-- ── References ──────────────────────────────────────────────────────
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua

local M = {}

--          ╭─────────────────────────────────────────────────────────╮
--          │                 Get all lines in buffer                 │
--          ╰─────────────────────────────────────────────────────────╯
function M.ai_buffer(ai_type)
  local start_line, end_line = 1, vim.fn.line('$')
  if ai_type == 'i' then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank =
      vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then
      return { from = { line = start_line, col = 1 } }
    end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

--          ╭─────────────────────────────────────────────────────────╮
--          │        Register all text objects with which-key         │
--          ╰─────────────────────────────────────────────────────────╯
---@param opts table
function M.ai_whichkey(opts)
  local objects = {
    -- Quotes
    { "'", desc = "' string" },
    { '"', desc = '" string' },
    { '`', desc = '` string' },
    { 'q', desc = 'quote `"\'' },
    -- Brackets
    { '(', desc = '() block' },
    { ')', desc = '() block with ws' },
    { '<', desc = '<> block' },
    { '>', desc = '<> block with ws' },
    { '[', desc = '[] block' },
    { ']', desc = '[] block with ws' },
    { '{', desc = '{} block' },
    { '}', desc = '{} with ws' },
    { 'b', desc = ')]} block' },
    -- Other
    { ' ', desc = 'whitespace' },
    { '_', desc = 'underscore' },
    { '?', desc = 'user prompt' },
    -- Code
    { 'a', desc = 'argument' },
    { 'c', desc = 'comment' },
    { 'C', desc = 'class' },
    { 'd', desc = 'digit(s)' },
    { 'e', desc = 'CamelCase / snake_case' },
    { 'f', desc = 'function' },
    { 'G', desc = 'entire file' },
    { 'i', desc = 'indent' }, -- snacks.scope
    { 'o', desc = 'block, conditional, loop' },
    { 't', desc = 'tag' },
    { 'u', desc = 'use/call' },
    { 'U', desc = 'use/call without dot' },
  }

  ---@type wk.Spec[]
  local ret = { mode = { 'o', 'x' } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend('force', {}, {
    around = 'a',
    inside = 'i',
    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub('^around_', ''):gsub('^inside_', '')
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == 'i' then desc = desc:gsub(' with ws', '') end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require('which-key').add(ret, { notify = false })
end

return M
