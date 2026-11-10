local function gitsigns_setup()
  vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

  require('gitsigns').setup({
    on_attach = function(buffer)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true }) end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']h', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, 'Next Hunk')

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[h', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, 'Prev Hunk')

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk, 'Stage Hunk')
      map('n', '<leader>hr', gitsigns.reset_hunk, 'Reset Hunk')

      map('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Stage Hunk')

      map('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, 'Reset Hunk')

      map('n', '<leader>hS', gitsigns.stage_buffer, 'Stage Buffer')
      map('n', '<leader>hR', gitsigns.reset_buffer, 'Reset Buffer')
      map('n', '<leader>hp', gitsigns.preview_hunk, 'Preview Hunk')
      map('n', '<leader>hi', gitsigns.preview_hunk_inline, 'Preview Hunk Inline')

      map('n', '<leader>hb', function() gitsigns.blame_line({ full = true }) end, 'Blame Line')

      map('n', '<leader>hd', gitsigns.diffthis, 'Diff This')

      map('n', '<leader>hD', function() gitsigns.diffthis('~') end, 'Diff This ~')

      -- map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
      -- map('n', '<leader>hq', gitsigns.setqflist)

      -- Toggles
      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, 'Toggle Current Line Blame')
      map('n', '<leader>tW', gitsigns.toggle_word_diff, 'Toggle Word Diff')

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Hunk')

      Snacks.toggle({
        name = 'Git Signs',
        get = function() return require('gitsigns.config').config.signcolumn end,
        set = function(state) require('gitsigns').toggle_signs(state) end,
      }):map('<leader>tG')
    end,
  })
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('gitsigns-setup', { clear = true }),
  once = true,
  callback = gitsigns_setup,
})
