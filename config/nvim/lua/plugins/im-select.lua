-- https://github.com/keaising/im-select.nvim

return {
  'keaising/im-select.nvim',
  enabled = function() return vim.fn.executable('im-select') == 1 end,
  event = 'InsertEnter',
  opts = {
    default_im_select = 'com.apple.keylayout.ABC',
    default_command = 'im-select',
  },
}
