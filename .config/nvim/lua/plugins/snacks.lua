-- References:
-- - https://github.com/folke/snacks.nvim
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/snacks_picker.lua
-- - https://linkarzu.com/posts/neovim/snacks-picker/

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true, timeout = 5000, style = 'fancy' },
    quickfile = { enabled = true },
    scope = { enabled = true }, -- ii, ai, [i, ]i
    scroll = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      enabled = true,
      sources = {
        buffers = {
          win = {
            input = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
            list = { keys = { ['d'] = 'bufdelete' } },
          },
        },
        explorer = {
          hidden = true,
        },
        files = {
          hidden = true,
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        -- stylua: ignore
        keys = {
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = '󰈞 ', key = 'f', desc = 'Find Files', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'M', desc = 'Mason', action = ':Mason', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
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
    -- { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification History' },
    { '<leader>.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer' },
    { '<leader>S', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer' },
    -- Terminal
    { '<c-\\>', function() Snacks.terminal() end, desc = 'Terminal', mode = { 'n', 't' } },
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
    { '<leader>gx', function() Snacks.gitbrowse() end, desc = 'Git Browse', mode = { 'n', 'v' } },
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
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end

        -- Override print to use snacks for `:=` command
        if vim.fn.has('nvim-0.11') == 1 then
          vim._print = function(_, ...) dd(...) end
        else
          vim.print = _G.dd
        end

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>ts')
        Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>tr')
        Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>tL')
        Snacks.toggle.diagnostics():map('<leader>td')
        Snacks.toggle.line_number():map('<leader>tl')
        Snacks.toggle
          .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map('<leader>tc')
        Snacks.toggle.treesitter():map('<leader>tT')
        Snacks.toggle
          .option('background', { off = 'light', on = 'dark', name = 'Dark Background' })
          :map('<leader>tB')
        Snacks.toggle.inlay_hints():map('<leader>th')
        Snacks.toggle.indent():map('<leader>tg')
        Snacks.toggle.dim():map('<leader>tD')
      end,
    })
  end,
}
