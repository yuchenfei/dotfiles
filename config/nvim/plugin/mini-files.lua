-- ╓
-- ║ https://nvim-mini.org/mini.nvim/doc/mini-files.html
-- ║ https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/mini-files.lua
-- ╙

local mini_files_loaded = false

local function load_mini_files()
  if mini_files_loaded then return require('mini.files') end

  vim.pack.add({ 'https://github.com/nvim-mini/mini.files' })

  local mini_files = require('mini.files')
  mini_files.setup({
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 50,
    },
  })

  mini_files_loaded = true
  return mini_files
end

local get_explorer_anchor = function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name == '' then return vim.fn.getcwd() end

  local path = vim.fs.normalize(buf_name)
  if vim.uv.fs_stat(path) ~= nil then return path end

  local parent = vim.fs.dirname(path)
  if parent ~= nil and vim.uv.fs_stat(parent) ~= nil then return parent end

  return vim.fn.getcwd()
end

-- Toggle explorer
vim.keymap.set('n', '<leader>e', function()
  local mini_files = load_mini_files()
  if not mini_files.close() then
    -- reveal current file
    -- https://github.com/nvim-mini/mini.nvim/discussions/395#discussioncomment-6418353
    mini_files.open(get_explorer_anchor())
    mini_files.reveal_cwd()
  end
end, { desc = 'Toggle mini.files' })

-- Toggle hidden files
local show_dotfiles = true
local filter_show = function(_) return true end
local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  require('mini.files').refresh({ content = { filter = new_filter } })
end

-- Modify target window via split
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    local cur_target = require('mini.files').get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. ' split')
      return vim.api.nvim_get_current_win()
    end)

    require('mini.files').set_target_window(new_target)
  end

  local desc = 'Split ' .. direction
  vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
end

-- Set focused directory as current working directory
local set_cwd = function()
  local path = (require('mini.files').get_fs_entry() or {}).path
  if path == nil then return vim.notify('Cursor is not on valid entry') end
  vim.fn.chdir(vim.fs.dirname(path))
end

-- Yank in register full path of entry under cursor
local yank_path = function()
  local path = (require('mini.files').get_fs_entry() or {}).path
  if path == nil then return vim.notify('Cursor is not on valid entry') end
  vim.fn.setreg(vim.v.register, path)
end

-- Open path with system default handler (useful for non-text files)
local ui_open = function() vim.ui.open(require('mini.files').get_fs_entry().path) end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id

    map_split(buf_id, '<C-s>', 'belowright horizontal')
    map_split(buf_id, '<C-v>', 'belowright vertical')
    map_split(buf_id, '<C-t>', 'tab')

    vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = 'Toggle hidden files' })
    vim.keymap.set('n', 'g~', set_cwd, { buffer = buf_id, desc = 'Set cwd' })
    vim.keymap.set('n', 'gX', ui_open, { buffer = buf_id, desc = 'OS open' })
    vim.keymap.set('n', 'gy', yank_path, { buffer = buf_id, desc = 'Yank path' })
  end,
})

-- Set custom bookmarks
local set_mark = function(id, path, desc) require('mini.files').set_bookmark(id, path, { desc = desc }) end

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesExplorerOpen',
  callback = function()
    set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
    set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
    set_mark('~', '~', 'Home directory')
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionRename',
  callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
})
