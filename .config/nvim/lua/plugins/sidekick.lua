-- Reference:
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
          },
          mux = {
            enabled = true,
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
        '<leader>aa',
        function() require('sidekick.cli').toggle() end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function() require('sidekick.cli').select({ filter = { installed = true } }) end,
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function() require('sidekick.cli').close() end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>at',
        function() require('sidekick.cli').send({ msg = '{this}' }) end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function() require('sidekick.cli').send({ msg = '{file}' }) end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function() require('sidekick.cli').send({ msg = '{selection}' }) end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function() require('sidekick.cli').prompt() end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      -- Example of a keybinding to open Claude directly
      {
        '<leader>ac',
        function() require('sidekick.cli').toggle({ name = 'claude', focus = true }) end,
        desc = 'Sidekick Toggle Claude',
      },
      {
        '<leader>ag',
        function() require('sidekick.cli').toggle({ name = 'gemini', focus = true }) end,
        desc = 'Sidekick Toggle Gemini',
      },
      {
        '<leader>ga',
        function() require('sidekick.cli').toggle({ name = 'gac', focus = true }) end,
        desc = 'Sidekick Auto Commit',
      },
    },
  },
}
