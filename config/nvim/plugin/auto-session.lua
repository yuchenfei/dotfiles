---@type AutoSession.Config
local opts = {
  enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= 'true',
  post_restore_cmds = {
    -- Forces Neovim to re-detect the filetype and attach Treesitter
    function() vim.cmd('bufdo e') end,
  },
}

local function auto_session_setup()
  vim.pack.add({ 'https://github.com/rmagatti/auto-session' })
  require('auto-session').setup(opts)
end

auto_session_setup()
