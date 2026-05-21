vim.pack.add({ 'https://github.com/rmagatti/auto-session' })

---@type AutoSession.Config
local opts = {
  post_restore_cmds = {
    -- Forces Neovim to re-detect the filetype and attach Treesitter
    function() vim.cmd('bufdo e') end,
  },
}

require('auto-session').setup(opts)
