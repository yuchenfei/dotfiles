-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- References:
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
-- - https://github.com/AstroNvim/AstroNvim/blob/main/lua/astronvim/plugins/neo-tree.lua

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<CR>', desc = 'Toggle Explorer' },
    {
      '<leader>be',
      function()
        require('neo-tree.command').execute({ source = 'buffers', toggle = true })
      end,
      desc = 'Buffer Explorer',
    },
    {
      '<leader>ge',
      function()
        require('neo-tree.command').execute({ source = 'git_status', toggle = true })
      end,
      desc = 'Git Explorer',
    },
  },
  opts = {
    close_if_last_window = true,
    source_selector = {
      winbar = true,
      content_layout = 'center',
      -- HACK: fix neo-tree source selector tab separator black bg
      -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/groups/integrations/neotree.lua
      highlight_separator = 'NeoTreeTabInactive',
      highlight_separator_active = 'NeoTreeTabInactive',
    },
    window = {
      mappings = {
        ['l'] = 'open',
        ['h'] = 'close_node',
        ['<space>'] = 'none',
        ['[b'] = 'prev_source',
        [']b'] = 'next_source',
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
  },
}
