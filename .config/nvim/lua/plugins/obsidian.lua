-- References:
--  - https://github.com/obsidian-nvim/obsidian.nvim

---@type LazySpec
return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- use latest release, remove to use latest commit
    ft = 'markdown',
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
      callbacks = {
        post_set_workspace = function(workspace)
          local path = vim.fs.normalize(tostring(workspace.path))
          -- Snacks.toggle.diagnostics():set(false)
          -- disable diagnostics in obsidian workspace
          if vim.uv.cwd() == path then Snacks.toggle.diagnostics():set(false) end
        end,
      },
    },
  },
}
