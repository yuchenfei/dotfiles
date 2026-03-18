-- References:
--  - https://github.com/hakonharnes/img-clip.nvim
--  - https://github.com/linkarzu/dotfiles-latest/blob/main/neovim/neobean/lua/config/keymaps.lua#L1308-L1308

---@type LazySpec
return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    default = {
      -- file and directory options
      use_absolute_path = false,
      relative_to_current_file = false,

      dir_path = 'assets',

      prompt_for_file_name = false,
      file_name = '%y%m%d-%H%M%S',

      extension = 'avif',
      process_cmd = 'convert - -quality 75 avif:-',
    },
    filetypes = {
      markdown = {
        url_encode_path = true,
      },
      AvanteInput = {
        drag_and_drop = {
          insert_mode = true,
        },
      },
    },
  },
  keys = {
    { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
  },
}
