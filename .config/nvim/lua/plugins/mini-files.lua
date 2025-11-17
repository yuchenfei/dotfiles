-- References:
-- - https://github.com/nvim-mini/mini.files
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/mini-files.lua

local function is_file(buf_name)
  if buf_name == '' then return false end
  if vim.fn.filereadable(buf_name) == 0 then return false end
  return true
end

---@type LazySpec
return {
  'nvim-mini/mini.files',
  keys = {
    {
      '<leader>e',
      function()
        if not require('mini.files').get_explorer_state() then
          local buf_name = vim.api.nvim_buf_get_name(0)
          require('mini.files').open(is_file(buf_name) and buf_name or nil)
        end
      end,
      desc = 'Explorer MiniFiles',
    },
  },
  opts = {
    mappings = {
      close = 'q',
      go_in_plus = 'l',
      go_in = 'L',
      go_out_plus = 'h',
      go_out = 'H',
      go_in_horizontal = '<C-s>', -- custom
      go_in_vertical = '<C-v>', -- custom
      go_in_tab = '<C-t>', -- custom
      mark_goto = "'",
      mark_set = 'm',
      reset = '<BS>',
      reveal_cwd = '@',
      change_cwd = 'g~', -- custom
      toggle_hidden = 'g.', -- custom
      system_open = 'gx', -- custom
      yank_path = 'gy', -- custom
      show_help = 'g?',
      synchronize = '=',
      trim_left = '<',
      trim_right = '>',
    },
    windows = {
      preview = true,
      width_focus = 30,
      idth_preview = 30,
    },
  },
  config = function(_, opts)
    require('mini.files').setup(opts)

    local map_split = function(buf_id, lhs, direction)
      local rhs = function()
        local new_target_window
        local cur_target_window = require('mini.files').get_explorer_state().target_window
        if cur_target_window ~= nil then
          vim.api.nvim_win_call(cur_target_window, function()
            if direction == 'tab' then
              vim.cmd(direction .. ' split')
            else
              vim.cmd('belowright ' .. direction .. ' split')
            end
            new_target_window = vim.api.nvim_get_current_win()
          end)

          require('mini.files').set_target_window(new_target_window)
          require('mini.files').go_in({ close_on_file = true })
        end
      end
      local desc = 'Open in ' .. direction .. ' split'
      vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    local show_dotfiles = true
    local filter_show = function(fs_entry) return true end
    local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      require('mini.files').refresh({ content = { filter = new_filter } })
    end

    local files_set_cwd = function()
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      if cur_directory ~= nil then vim.fn.chdir(cur_directory) end
    end

    local yank_path = function()
      local path = (MiniFiles.get_fs_entry() or {}).path
      if path == nil then return vim.notify('Cursor is not on valid entry') end
      vim.fn.setreg(vim.v.register, path)
      vim.notify('Yanked path: ' .. path)
    end

    local system_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id

        local map = function(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
        end

        map_split(buf_id, opts.mappings.go_in_horizontal, 'horizontal')
        map_split(buf_id, opts.mappings.go_in_vertical, 'vertical')
        map_split(buf_id, opts.mappings.go_in_tab, 'tab')

        map(opts.mappings.toggle_hidden, toggle_dotfiles, 'Toggle hidden files')
        map(opts.mappings.change_cwd, files_set_cwd, 'Set cwd')
        map(opts.mappings.system_open, system_open, 'System open')
        map(opts.mappings.yank_path, yank_path, 'Yank path')
      end,
    })

    local set_mark = function(id, path, desc) MiniFiles.set_bookmark(id, path, { desc = desc }) end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesExplorerOpen',
      callback = function()
        set_mark('c', vim.fn.stdpath('config'), 'Config') -- path
        set_mark('w', vim.fn.getcwd, 'Working directory') -- callable
        set_mark('~', '~', 'Home directory')
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesActionRename',
      callback = function(event) Snacks.rename.on_rename_file(event.data.from, event.data.to) end,
    })
  end,
}
