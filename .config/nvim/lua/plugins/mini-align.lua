-- Align text interactively
-- See `:help MiniAlign-examples` and `:help MiniAlign-modifiers-builtin`

return {
  'nvim-mini/mini.align',
  event = 'VeryLazy',
  opts = {
    mappings = {
      start = 'gl',
      start_with_preview = 'gL',
    },
  },
}
