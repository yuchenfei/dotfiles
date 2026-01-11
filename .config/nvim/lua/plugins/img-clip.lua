-- https://github.com/hakonharnes/img-clip.nvim

return {
  'HakonHarnes/img-clip.nvim',
  ft = { 'markdown', 'codecompanion' },
  keys = {
    { '<leader>p', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
  },
  opts = {
    default = {
      file_name = '%y%m%d-%H%M%S',
      -- required for Windows users
      -- use_absolute_path = true,
      prompt_for_file_name = false,
      embed_image_as_base64 = false,
      drag_and_drop = {
        insert_mode = false, -- true, notify 'content is not an image' when copying text
      },
    },
    filetypes = {
      markdown = {
        dir_path = './attachments',
        -- template options
        template = '![Image$CURSOR]($FILE_PATH)',
        url_encode_path = true,
        -- image options
        extension = 'avif',
        process_cmd = 'convert - -quality 75 avif:-',
        copy_images = true,
        download_images = false,
      },
      codecompanion = {
        template = '[Image]($FILE_PATH)',
        use_absolute_path = true,
      },
    },
  },
}
