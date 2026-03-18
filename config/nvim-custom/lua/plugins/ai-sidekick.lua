-- References:
--  - https://github.com/folke/sidekick.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/ai/sidekick.lua

---@type LazySpec
return {
  {
    'folke/sidekick.nvim',
    opts = function()
      Snacks.toggle({
        name = 'Sidekick NES',
        get = function() return require('sidekick.nes').enabled end,
        set = function(state) require('sidekick.nes').enable(state) end,
      }):map('<leader>tN')

      return {
        cli = {
          win = {
            split = {
              width = 60,
            },
            keys = {
              buffers = { '<M-b>', 'buffers', mode = 'nt', desc = 'open buffer picker' },
              files = { '<M-f>', 'files', mode = 'nt', desc = 'open file picker' },
            },
          },
          mux = {
            enabled = false, -- conflict with skhd script
            backend = 'tmux',
          },
          tools = {
            gac = { cmd = { 'gac', '-os' } },
          },
        },
      }
    end,
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function() require('sidekick.cli').toggle() end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>ao',
        function() require('sidekick.cli').toggle({ name = 'opencode', focus = true }) end,
        desc = 'Sidekick OpenCode',
      },
      {
        '<leader>aO',
        function() require('sidekick.cli').select({ filter = { installed = true } }) end,
        desc = 'Sidekick Select CLI',
      },
      {
        '<leader>ad',
        function() require('sidekick.cli').close() end,
        desc = 'Sidekick Detach a CLI Session',
      },
      {
        '<leader>at',
        function() require('sidekick.cli').send({ msg = '{this}' }) end,
        mode = { 'x', 'n' },
        desc = 'Sidekick Send This',
      },
      {
        '<leader>av',
        function() require('sidekick.cli').send({ msg = '{selection}' }) end,
        mode = { 'x' },
        desc = 'Sidekick Send Visual Selection',
      },
      {
        '<leader>ap',
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      {
        '<leader>ga',
        function() require('sidekick.cli').toggle({ name = 'gac', focus = true }) end,
        desc = 'Sidekick Auto Commit',
      },
    },
  },
}
