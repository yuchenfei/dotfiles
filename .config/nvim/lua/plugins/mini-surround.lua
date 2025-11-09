-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- Examples:
--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
--  - sd'   - [S]urround [D]elete [']quotes
--  - sr)'  - [S]urround [R]eplace [)] [']
--
-- References:
--  - https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-surround.md

return {
  'nvim-mini/mini.surround',
  event = 'VeryLazy',
  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = 'gsa', -- Add surrounding in Normal and Visual modes
      delete = 'gsd', -- Delete surrounding
      find = 'gsf', -- Find surrounding (to the right)
      find_left = 'gsF', -- Find surrounding (to the left)
      highlight = 'gsh', -- Highlight surrounding
      replace = 'gsr', -- Replace surrounding

      suffix_last = 'l', -- Suffix to search with "prev" method
      suffix_next = 'n', -- Suffix to search with "next" method
    },
  },
}
