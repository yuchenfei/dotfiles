local function map(key, func, desc, mode)
  mode = mode or { 'n', 'v' }
  vim.keymap.set(mode, key, func, { desc = desc, silent = true })
end

local function comment_box_setup()
  vim.pack.add({ 'https://github.com/LudoPinelli/comment-box.nvim' })

  require('comment-box').setup()

  map('<Leader>cb', '<Cmd>CBlcbox<CR>', 'Box Title')
  map('<Leader>ct', '<Cmd>CBllline<CR>', 'Titled Line')
  map('<Leader>cl', '<Cmd>CBline<CR>', 'Simple Line', 'n')
  map('<Leader>cm', '<Cmd>CBllbox16<CR>', 'Marked')
  map('<Leader>cq', '<Cmd>CBllbox13<CR>', 'Quoted')
  map('<Leader>cd', '<Cmd>CBd<CR>', 'Remove a Box')
  map('<Leader>cy', '<Cmd>CBy<CR>', 'Yank Content')
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('comment-box-setup', { clear = true }),
  once = true,
  callback = comment_box_setup,
})
