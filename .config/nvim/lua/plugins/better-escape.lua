-- Map keys without delay when typing
-- https://github.com/max397574/better-escape.nvim

return {
  'max397574/better-escape.nvim',
  event = 'VeryLazy',
  opts = {
    mappings = {
      t = {
        j = {
          k = false,
        },
      },
    },
  },
}
