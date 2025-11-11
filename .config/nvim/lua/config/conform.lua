-- https://github.com/stevearc/conform.nvim
-- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
-- https://www.reddit.com/r/neovim/comments/1j55o9c/share_your_custom_toggles_using_snacks_toggle/

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    nix = { 'nixfmt' }, -- Installed via nixpkgs
    -- Conform will run multiple formatters sequentially
    -- python = { 'isort', 'black' },
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { 'rustfmt', lsp_format = 'fallback' },
    -- Conform will run the first available formatter
    -- javascript = { 'prettierd', 'prettier', stop_after_first = true },
  },
  -- There is a similar affordance for format_after_save, which uses BufWritePost.
  -- This is good for formatters that are too slow to run synchronously.
  format_after_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = { 'c', 'cpp' }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    -- ...additional logic...
    if bufname:match('/node_modules/') then return end
    return { lsp_format = 'fallback' }
  end,
  notify_on_error = false,
})

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

Snacks.toggle
  .new({
    id = 'format_on_save',
    name = 'Auto Format (Global)',
    get = function() return not vim.g.disable_autoformat end,
    set = function(state) vim.g.disable_autoformat = not state end,
  })
  :map('<leader>tf')

Snacks.toggle
  .new({
    id = 'format_on_save_buffer',
    name = 'Auto Format (Buffer)',
    get = function() return not vim.b.disable_autoformat end,
    set = function(state) vim.b.disable_autoformat = not state end,
  })
  :map('<leader>tF')
