local function kitty_scrollback_setup()
  vim.pack.add({ 'https://github.com/mikesmithgh/kitty-scrollback.nvim' })
  require('kitty-scrollback').setup()
end

vim.schedule(kitty_scrollback_setup)
