-- References:
-- - https://github.com/AndrewRadev/switch.vim
-- - https://github.com/AndrewRadev/switch.vim/wiki

return {
  'AndrewRadev/switch.vim',
  cmd = { 'Switch' },
  keys = {
    { '`', function() vim.cmd.Switch() end, desc = 'Switch strings' },
  },
  init = function()
    vim.g.switch_mapping = ''
    vim.g.switch_custom_definitions = {
      { 'height', 'width' },
    }
  end,
}
