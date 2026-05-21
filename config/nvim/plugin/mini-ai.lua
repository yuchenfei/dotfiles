-- https://nvim-mini.org/mini.nvim/doc/mini-ai.html

local function ai_setup()
  vim.pack.add({ 'https://github.com/nvim-mini/mini.ai' })

  local ai = require('mini.ai')
  ai.setup({
    custom_textobjects = {
      -- Builtin textobjects
      -- b()[]{}<>
      -- q'"`
      -- ? a f t
      f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }), -- function
      g = require('util.mini').ai_buffer, -- buffer
      u = ai.gen_spec.function_call(), -- u for "Usage"
      U = ai.gen_spec.function_call({ name_pattern = '[%w_]' }), -- without dot in function name
    },
    mappings = {
      around_next = 'aN',
      inside_next = 'iN',
      around_last = 'aL',
      inside_last = 'iL',
    },
    n_lines = 500,
  })
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('mini-ai-setup', { clear = true }),
  once = true,
  callback = function()
    ai_setup()
    require('util.mini').ai_whichkey()
  end,
})
