local function treesitter_context_setup()
  vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-context' })

  local tsc = require('treesitter-context')

  tsc.setup({
    max_lines = 3,
  })

  Snacks.toggle({
    name = 'Treesitter Context',
    get = tsc.enabled,
    set = function(state)
      if state then
        tsc.enable()
      else
        tsc.disable()
      end
    end,
  }):map('<leader>tt')
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('treesitter-context-setup', { clear = true }),
  once = true,
  callback = treesitter_context_setup,
})
