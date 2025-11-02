-- [[ References ]]
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.o.breakindent = true -- Enable break indent
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true -- You can also add relative line numbers, to help with jumping.
vim.o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.smartcase = true -- No ignore case when pattern has uppercase
vim.o.splitbelow = true -- Configure how new splits should be opened
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.undofile = true -- Save undo history
vim.o.updatetime = 250 -- Decrease update time

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
