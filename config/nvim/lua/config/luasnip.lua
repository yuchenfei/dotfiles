-- ── References ──────────────────────────────────────────────────────
-- - https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua
-- - https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

--          ╭─────────────────────────────────────────────────────────╮
--          │                        Markdown                         │
--          ╰─────────────────────────────────────────────────────────╯

local function create_code_block_snippet(lang)
  return s({
    trig = lang,
    name = 'Codeblock',
    desc = lang .. ' codeblock',
  }, {
    t({ '```' .. lang, '' }),
    i(1),
    t({ '', '```' }),
  })
end

local languages = {
  'bash',
  'cpp',
  'css',
  'csv',
  'dockerfile',
  'go',
  'html',
  'java',
  'javascript',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'markdown_inline',
  'nix',
  'python',
  'regex',
  'sql',
  'toml',
  'txt',
  'yaml',
}

local snippets = {}

for _, lang in ipairs(languages) do
  table.insert(snippets, create_code_block_snippet(lang))
end

ls.add_snippets('markdown', snippets)
