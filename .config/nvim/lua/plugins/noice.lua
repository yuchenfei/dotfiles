-- References:
--  - https://github.com/folke/noice.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua

return {
  'folke/noice.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  },
  -- stylua: ignore
  keys = {
    { '<S-Enter>', function() require('noice').redirect(vim.fn.getcmdline()) end, mode = 'c', desc = 'Redirect Cmdline' },
    { '<leader>nl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
    { '<leader>nh', function() require('noice').cmd('history') end, desc = 'Noice History' },
    { '<leader>na', function() require('noice').cmd('all') end, desc = 'Noice All' },
    { '<leader>nd', function() require('noice').cmd('dismiss') end, desc = 'Dismiss All' },
    { '<leader>np', function() require('noice').cmd('pick') end, desc = 'Noice Picker' },
    -- Lsp Hover Doc Scrolling
    { '<c-f>', function() if not require('noice.lsp').scroll(4) then return '<c-f>' end end, silent = true, expr = true, desc = 'Scroll Forward', mode = { 'i', 'n', 's' } },
    { '<c-b>', function() if not require('noice.lsp').scroll(-4) then return '<c-b>' end end, silent = true, expr = true, desc = 'Scroll Backward', mode = { 'i', 'n', 's' } },
  },
}
