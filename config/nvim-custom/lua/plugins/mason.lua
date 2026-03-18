-- https://github.com/mason-org/mason.nvim

return {
  {
    'mason-org/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    keys = { { '<leader>lm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'tree-sitter-cli',
        'ruff', -- https://docs.astral.sh/ruff/editors/setup/
        'shfmt', -- https://github.com/patrickvane/shfmt
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end)
    end,
  },
}
