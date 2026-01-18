-- References:
--  - https://github.com/obsidian-nvim/obsidian.nvim

---@type LazySpec
return {
  {
    'obsidian-nvim/obsidian.nvim',
    ft = 'markdown',
    cmd = 'Obsidian',
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false, -- this will be removed in the next major release
      workspaces = {
        {
          name = 'notebook',
          path = '~/Notes/Notebook',
        },
      },
      note_id_func = function(title)
        if title:match('^%l%l%l%l%s') then
          return title
        elseif title:match('^-') then
          return (title:gsub('^-%s*', ''))
        else
          local prefix = ''
          for _ = 1, 4 do
            prefix = prefix .. string.char(math.random(97, 122))
          end
          return prefix .. ' ' .. title
        end
      end,
      wiki_link_func = function(opts)
        opts.label = opts.id
        ---@diagnostic disable-next-line: param-type-mismatch
        return require('obsidian.builtin').wiki_link_id_prefix(opts)
      end,
      templates = {
        folder = 'Templates',
        date_format = '%Y-%m-%d %a',
        time_format = '%H:%M',
      },
      daily_notes = {
        folder = 'Timestamps',
        date_format = '%Y/%m-%B/%Y-%m-%d-%A',
        default_tags = nil,
        workdays_only = false,
        template = 'Daily Notes Template',
      },
      ui = {
        enable = false,
      },
      callbacks = {
        post_set_workspace = function(workspace)
          -- turn off diagnostics in obsidian workspace
          local path = vim.fs.normalize(tostring(workspace.path))
          if vim.uv.cwd() == path then Snacks.toggle.diagnostics():set(false) end
          -- set locale to C for time formatting
          os.setlocale('C', 'time')
        end,
      },
      footer = {
        format = '{{backlinks}} backlinks  {{words}} words  {{chars}} chars',
        separator = '',
      },
    },
    keys = {
      { '<leader>no', '<Cmd>Obsidian quick_switch<CR>', desc = 'Open Note' },
      { '<leader>nx', '<Cmd>Obsidian open<CR>', desc = 'Open Note in Obsidian' },
      { '<leader>nn', '<Cmd>Obsidian new<CR>', desc = 'Create Note' },
      { '<leader>nN', '<Cmd>Obsidian new_from_template<CR>', desc = 'Create Note from Template' },
      { '<leader>nd', '<Cmd>Obsidian today<CR>', desc = 'Daily Notes - Today' },
      { '<leader>nD', '<Cmd>Obsidian dailies -10<CR>', desc = 'Daily Notes' },
      {
        '<leader>nc',
        ":'<,'>Obsidian extract_note<CR>",
        mode = 'v',
        desc = 'New Note from Content Selection',
      },
      {
        '<leader>nt',
        ":'<,'>Obsidian link_new<CR>",
        mode = 'v',
        desc = 'New Note from Title Selection',
      },
      {
        '<leader>nl',
        ":'<,'>Obsidian link<CR>",
        mode = 'v',
        desc = 'Link selection to Note',
      },
      { '<leader>nl', '<Cmd>Obsidian links<CR>', desc = 'Links' },
      { '<leader>nb', '<Cmd>Obsidian backlinks<CR>', desc = 'Backlinks' },
      { '<leader>nt', '<Cmd>Obsidian tags<CR>', desc = 'Tags' },
    },
  },
  {
    'folke/which-key.nvim',
    opts = {
      spec = {
        { '<leader>n', group = 'Obsidian', icon = '󰠮' },
      },
    },
  },
}
