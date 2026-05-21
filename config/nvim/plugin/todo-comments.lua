---@type TodoOptions
local opts = {}

local function todo_comments_setup()
  vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

  require('todo-comments').setup(opts)

  vim.keymap.set('n', ']t', function() require('todo-comments').jump_next() end, { desc = 'Next todo comment' })
  vim.keymap.set('n', '[t', function() require('todo-comments').jump_prev() end, { desc = 'Previous todo comment' })

  vim.keymap.set('n', '<leader>ft', function() Snacks.picker.todo_comments() end, { desc = 'Todo' })
  vim.keymap.set(
    'n',
    '<leader>fT',
    function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } }) end,
    { desc = 'Todo/Fix/Fixme' }
  )
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('todo-comments-setup', { clear = true }),
  once = true,
  callback = todo_comments_setup,
})
