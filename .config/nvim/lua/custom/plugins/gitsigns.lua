-- Adds git related signs to the gutter, as well as utilities for managing changes
-- https://github.com/lewis6991/gitsigns.nvim
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true })
        end

        -- stylua: ignore start
        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Jump to the next git [h]unk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Jump to the previous git [h]unk')
        map('n', ']H', function() gs.nav_hunk('last') end, 'Jump to the last git [h]unk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'Jump to the first git [h]unk')

        -- Actions
        map({ 'n', 'x' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'x' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>gS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>gR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>gu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>gp', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<leader>gb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<leader>gB', function() gs.blame() end, 'Blame Buffer')
        map('n', '<leader>gd', gs.diffthis, 'Diff This')
        map('n', '<leader>gD', function() gs.diffthis('~') end, 'Diff This ~')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'GitSigns Select Hunk')
      end,
    },
  },
  {
    'gitsigns.nvim',
    opts = function()
      -- Toggles
      Snacks.toggle
        .new({
          name = '[G]it Signs',
          get = function()
            return require('gitsigns.config').config.signcolumn
          end,
          set = function(state)
            require('gitsigns').toggle_signs(state)
          end,
        })
        :map '<leader>tg'

      Snacks.toggle
        .new({
          name = 'Git [W]ord Diff',
          get = function()
            return require('gitsigns.config').config.word_diff
          end,
          set = function(state)
            require('gitsigns').toggle_word_diff(state)
          end,
        })
        :map '<leader>tw'

      Snacks.toggle
        .new({
          name = 'Git [B]lame',
          get = function()
            return require('gitsigns.config').config.current_line_blame
          end,
          set = function(state)
            require('gitsigns').toggle_current_line_blame(state)
          end,
        })
        :map '<leader>tb'
    end,
  },
}
