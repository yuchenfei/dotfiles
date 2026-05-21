-- ╓
-- ║ https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- ║ https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- ║ https://neovim.io/doc/user/options/#options
-- ╙

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ╭─────────────────────────────────────────────────────────╮
-- │                     Setting options                     │
-- ╰─────────────────────────────────────────────────────────╯
-- See `:help vim.o`
-- For more options, you can see `:help option-list`
-- vim.o.breakindent = true -- Enable break indent
vim.o.cmdheight = 0
vim.o.confirm = true -- Confirm to save changes before exiting modified buffer
vim.o.cursorline = true -- Show which line your cursor is on
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
vim.o.laststatus = 3 -- Global statusline
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.number = true -- Make line numbers default
vim.o.relativenumber = true
vim.o.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.
vim.o.showmode = false -- Don't show the mode, since it's already in the status line
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.smartcase = true -- Don't ignore case with capitals
vim.o.splitbelow = true
vim.o.splitright = true -- Configure how new splits should be opened
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
vim.o.undofile = true -- Save undo history
vim.o.updatetime = 250 -- Decrease update time
vim.o.wrap = true -- Enable soft line wrap

-- Folding
-- https://neovim.io/doc/user/fold/#_3.-fold-options
vim.o.foldlevel = 99
vim.o.foldtext = 'v:lua.custom_foldtext()'
vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
}

-- Indentation
-- https://gist.github.com/LunarLambda/4c444238fb364509b72cfb891979f1dd
vim.o.expandtab = true -- Use spaces to insert a <Tab>, to insert real tab, use CTRL-V<Tab>
vim.o.tabstop = 2 -- It defines the width of a <Tab>
vim.o.shiftwidth = 2 -- Size of an indent
vim.o.softtabstop = -1 -- shiftwidth for start of a line, this for anywhere else

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- https://www.reddit.com/r/neovim/comments/1fzn1zt/custom_fold_text_function_with_treesitter_syntax/
local function fold_virt_text(result, s, lnum, coloff)
  if not coloff then coloff = 0 end
  local text = ''
  local hl
  for i = 1, #s do
    local char = s:sub(i, i)
    local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
    local _hl = hls[#hls]
    if _hl then
      local new_hl = '@' .. _hl.capture
      if new_hl ~= hl then
        table.insert(result, { text, hl })
        text = ''
        hl = nil
      end
      text = text .. char
      hl = new_hl
    else
      text = text .. char
    end
  end
  table.insert(result, { text, hl })
end

function _G.custom_foldtext()
  local start = vim.fn.getline(vim.v.foldstart):gsub('\t', string.rep(' ', vim.o.tabstop))
  local end_str = vim.fn.getline(vim.v.foldend)
  local end_ = vim.trim(end_str)
  local result = {}
  fold_virt_text(result, start, vim.v.foldstart - 1)
  table.insert(result, { ' ... ', 'Delimiter' })
  fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match('^(%s+)') or ''))
  return result
end
