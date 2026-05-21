local function autopairs_setup()
  vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })
  require('nvim-autopairs').setup({
    fast_wrap = {
      map = '<S-M-e>',
    },
  })
end

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
  group = vim.api.nvim_create_augroup('nvim-autopairs-setup', { clear = true }),
  once = true,
  callback = function() autopairs_setup() end,
})
