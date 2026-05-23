-- ╓
-- ║ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- ║ https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- ║ https://neovim.io/doc/user/map/#key-mapping
-- ╙

local function map(key, func, desc, opts)
  opts = opts or {}
  local mode = opts.mode or 'n'
  opts.mode = nil
  opts.desc = desc
  vim.keymap.set(mode, key, func, opts)
end

-- ╭─────────────────────────────────────────────────────────╮
-- │                      Basic Keymaps                      │
-- ╰─────────────────────────────────────────────────────────╯
-- See `:help vim.keymap.set()`

-- better up/down
map('j', "v:count == 0 ? 'gj' : 'j'", 'Down', { mode = { 'n', 'x', 'v' }, expr = true, silent = true })
map('k', "v:count == 0 ? 'gk' : 'k'", 'Up', { mode = { 'n', 'x', 'v' }, expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('<C-h>', '<C-w>h', 'Go to Left Window', { remap = true })
map('<C-j>', '<C-w>j', 'Go to Lower Window', { remap = true })
map('<C-k>', '<C-w>k', 'Go to Upper Window', { remap = true })
map('<C-l>', '<C-w>l', 'Go to Right Window', { remap = true })

-- Resize window using <ctrl> arrow keys
map('<C-Up>', '<cmd>resize +2<cr>', 'Increase Window Height')
map('<C-Down>', '<cmd>resize -2<cr>', 'Decrease Window Height')
map('<C-Left>', '<cmd>vertical resize -2<cr>', 'Decrease Window Width')
map('<C-Right>', '<cmd>vertical resize +2<cr>', 'Increase Window Width')

-- Move Lines
map('<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", 'Move Down')
map('<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", 'Move Up')
map('<A-j>', '<esc><cmd>m .+1<cr>==gi', 'Move Down', { mode = 'i' })
map('<A-k>', '<esc><cmd>m .-2<cr>==gi', 'Move Up', { mode = 'i' })
map('<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", 'Move Down', { mode = 'v' })
map('<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", 'Move Up', { mode = 'v' })

-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
map('<Esc>', '<cmd>nohlsearch<cr>')

-- Buffer
map('<leader>bb', '<cmd>e #<cr>', 'Switch to Other Buffer')
map('<leader>bD', '<cmd>:bd<cr>', 'Delete Buffer and Window')
map('<leader>bd', function() Snacks.bufdelete() end, 'Delete Buffer')
map('<leader>bo', function() Snacks.bufdelete.other() end, 'Delete Other Buffers')

-- Tab
map('L', 'gt', 'Go to next tab')
map('H', 'gT', 'Go to prev tab')
map('<C-w>t', function() vim.cmd('tab split') end, 'Open current buffer in new tab')

map('<leader>R', ':restart<cr>', 'Restart')
map('<leader>qq', '<cmd>qa<cr>', 'Quit All')

-- Top Pickers & Explorer
map('<leader><space>', function() Snacks.picker.smart() end, 'Smart Find Files')
map('<leader>,', function()
  Snacks.picker.buffers({
    on_show = function() vim.cmd.stopinsert() end,
    layout = { preset = 'ivy', layout = { position = 'bottom' } },
  })
end, 'Buffers')
map('<leader>:', function() Snacks.picker.command_history() end, 'Command History')
map('<leader>E', function() Snacks.explorer() end, 'File Explorer')

-- Find File
map('<leader>fC', function() Snacks.picker.commands() end, 'Commands')
map('<leader>fc', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, 'Find Config File')
map('<leader>fd', function() Snacks.picker.diagnostics_buffer() end, 'Buffer Diagnostics')
map('<leader>ff', function() Snacks.picker.files() end, 'Find Files')
map('<leader>fg', function() Snacks.picker.grep() end, 'Grep')
map('<leader>fG', function() Snacks.picker.grep_buffers() end, 'Grep Open Buffers')
map('<leader>fh', function() Snacks.picker.help() end, 'Help Pages')
map('<leader>fi', function() Snacks.picker.icons() end, 'Icons')
map('<leader>fk', function() Snacks.picker.keymaps() end, 'Keymaps')
map('<leader>fp', function() Snacks.picker.projects() end, 'Projects')
map('<leader>fr', function() Snacks.picker.recent() end, 'Recent')
map('<leader>fR', function() Snacks.picker.resume() end, 'Resume')
map('<leader>fw', function() Snacks.picker.grep_word() end, 'Visual selection or word', { mode = { 'n', 'x' } })

-- Git
map('<leader>gb', function() Snacks.git.blame_line() end, 'Git Blame Line')
map('<leader>gg', function() Snacks.lazygit() end, 'Lazygit')
map('<leader>gx', function() Snacks.gitbrowse() end, 'Git Browse', { mode = { 'n', 'x' } })
map(
  '<leader>ga',
  function()
    Snacks.terminal.get('gac -os', {
      auto_close = false,
      win = {
        position = 'float',
        height = 0.6,
        width = 0.6,
        border = true,
        title = ' AI Git Commit ',
        title_pos = 'center',
      },
    })
  end,
  'AI Commit'
)

-- Other
map('<leader>n', function() Snacks.picker.notifications() end, 'Notification History')
map('<leader>un', function() Snacks.notifier.hide() end, 'Dismiss All Notifications')
map('<c-/>', function() Snacks.terminal() end, 'Toggle Terminal', { mode = { 'n', 't' } })

vim.schedule(function()
  Snacks.toggle.line_number():map('<leader>tl')
  Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tL')
  Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tw')
end)
