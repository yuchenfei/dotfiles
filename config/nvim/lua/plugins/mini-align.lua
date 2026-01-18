-- Align text interactively
-- See `:help MiniAlign-examples` and `:help MiniAlign-modifiers-builtin`

return {
  'nvim-mini/mini.align',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    mappings = {
      start = 'gl',
      start_with_preview = 'gL',
    },
  },
}
