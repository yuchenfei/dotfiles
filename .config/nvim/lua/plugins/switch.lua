-- References:
-- - https://github.com/AndrewRadev/switch.vim
-- - https://github.com/AndrewRadev/switch.vim/wiki

--- @type LazySpec
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

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('switch-markdown', { clear = true }),
      pattern = { 'markdown' },
      callback = function()
        vim.b.switch_custom_definitions = {
          -- - [ ] → - [x] → - [-]
          {
            [ [=[\v^(\s*[*+-] )?\[ \]]=] ] = [=[\1[x]]=],
            [ [=[\v^(\s*[*+-] )?\[x\]]=] ] = [=[\1[-]]=],
            [ [=[\v^(\s*[*+-] )?\[-\]]=] ] = [=[\1[ ]]=],
          },
          -- 1. [ ] → 1. [x] → 1. [-]
          {
            [ [=[\v^(\s*\d+\. )?\[ \]]=] ] = [=[\1[x]]=],
            [ [=[\v^(\s*\d+\. )?\[x\]]=] ] = [=[\1[-]]=],
            [ [=[\v^(\s*\d+\. )?\[-\]]=] ] = [=[\1[ ]]=],
          },
          { '> [!TODO]', '> [!WIP]', '> [!DONE]', '> [!FAIL]' },
        }
      end,
    })
  end,
}
