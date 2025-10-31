-- https://github.com/folke/snacks.nvim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/snacks_picker.lua

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    explorer = {},
    lazygit = {},
    picker = {},
  },
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader>,',
      function()
        Snacks.picker.buffers({
          on_show = function() vim.cmd.stopinsert() end,
          layout = { preset = 'ivy', layout = { position = 'bottom' } },
        })
      end,
      desc = 'Buffers',
    },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
    { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    -- Find
    { '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    {
      '<leader>fc',
      function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
      desc = 'Config Files',
    },
    { '<leader>ff', function() Snacks.picker.files() end, desc = 'Files' },
    { '<leader>fg', function() Snacks.picker.git_files() end, desc = 'Git Files' },
    { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
    { '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
    -- Git
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit' },
    -- Grep
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Grep Current Buffer' },
    { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep' },
    {
      '<leader>sw',
      function() Snacks.picker.grep_word() end,
      desc = 'Grep Word',
      mode = { 'n', 'x' },
    },
    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    {
      '<leader>sD',
      function() Snacks.picker.diagnostics_buffer() end,
      desc = 'Buffer Diagnostics',
    },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<leader>sp', function() Snacks.picker.lazy() end, desc = 'Search for Plugin Spec' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>sr', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undo History' },
  },
}
