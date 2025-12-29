-- References:
--  - https://github.com/nvim-lualine/lualine.nvim
--  - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/ui.lua
--  - https://github.com/AndreM222/copilot-lualine

-- PERF: we don't need this lualine require madness 🤷
local lualine_require = require('lualine_require')
lualine_require.require = require

vim.o.laststatus = vim.g.lualine_laststatus

local palette = require('catppuccin.palettes').get_palette('mocha')

local sections = {}
if vim.g.neovim_mode == 'sticky' then
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {
      { 'location', separator = ' ', padding = { left = 1, right = 0 } },
      { 'progress', padding = { left = 0, right = 1 } },
    },
  }
else
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filetype', icon_only = true, padding = { left = 1, right = 0 } },
      {
        'filename',
        padding = { left = 0, right = 1 },
        symbols = { modified = ' ', readonly = '󰌾 ' },
      },
    },
    lualine_c = {
      {
        'branch',
        color = { fg = palette.peach, bg = palette.surface1, gui = 'bold' },
      },
      {
        'diff',
        padding = { left = 0, right = 1 },
        symbols = { added = ' ', modified = ' ', removed = ' ' },
        color = { bg = palette.surface1 },
        source = function()
          local gitsigns = vim.b.gitsigns_status_dict
          if gitsigns then
            return {
              added = gitsigns.added,
              modified = gitsigns.changed,
              removed = gitsigns.removed,
            }
          end
        end,
      },
      'diagnostics',
    },
    lualine_x = {
      { -- showmode (@recording messages)
        function() return require('noice').api.status.mode.get() end,
        cond = function() return package.loaded['noice'] and require('noice').api.status.mode.has() end,
        color = function() return { fg = palette.peach } end,
      },
      { -- showcmd
        function() return require('noice').api.status.command.get() end,
        cond = function()
          return package.loaded['noice'] and require('noice').api.status.command.has()
        end,
        color = function() return { fg = palette.mauve } end,
      },
      -- HACK: https://github.com/stevearc/overseer.nvim/issues/457#issuecomment-3547557005
      { 'overseer', colored = false },
      {
        'copilot',
        symbols = {
          status = {
            hl = {
              enabled = palette.green, -- #50FA7B
              sleep = palette.sapphire, -- #AEB7D0
              disabled = palette.overlay0, -- #6272A4
              warning = palette.peach, -- #FFB86C
              unknown = palette.red, -- #FF5555
            },
          },
          spinners = 'dots_pulse',
          spinner_color = palette.sapphire, -- #6272A4
        },
        show_colors = true,
      },
      -- Conform formatter status
      -- - https://github.com/nvim-lualine/lualine.nvim/discussions/1153
      {
        function()
          local status, conform = pcall(require, 'conform')
          if not status then return 'Conform not installed' end

          -- Get formatters will run for the current buffer
          local formatters, lsp = conform.list_formatters_to_run()
          if formatters and #formatters > 0 then
            local formatter_names = {}
            local seen = {}

            for _, formatter in ipairs(formatters) do
              local name = formatter.name

              -- simplify formatter names
              if vim.startswith(name, 'ruff_') then name = 'ruff' end
              if name == 'injected' then break end

              if not seen[name] then
                table.insert(formatter_names, name)
                seen[name] = true
              end
            end

            return '󰷈 ' .. table.concat(formatter_names, ' ')
          end
          if not lsp then return '' end

          -- Get LSP with formatter capability
          local bufnr = vim.api.nvim_get_current_buf()
          local lsp_clients = require('conform.lsp_format').get_format_clients({ bufnr = bufnr })

          if not vim.tbl_isempty(lsp_clients) then
            local lsp_names = {}

            for _, client in ipairs(lsp_clients) do
              table.insert(lsp_names, client.name)
            end
            return '󰷈 LSP[' .. table.concat(lsp_names, ' ') .. ']'
          end

          return ''
        end,
        color = function() return { fg = palette.green } end,
      },
    },
    lualine_y = {
      { 'filesize', separator = ' ', padding = { left = 1, right = 0 } },
      { 'encoding', separator = ' ', padding = 0 },
      {
        'fileformat',
        padding = { left = 0, right = 1 },
        cond = function() return vim.bo.buftype == '' end,
      },
    },
    lualine_z = {
      { 'location', separator = ' ', padding = { left = 1, right = 0 } },
      { 'progress', padding = { left = 0, right = 1 } },
    },
  }
end

require('lualine').setup({
  options = {
    globalstatus = vim.o.laststatus == 3,
    section_separators = '',
    component_separators = '',
    disabled_filetypes = {
      statusline = { 'snacks_dashboard' },
    },
  },
  sections = sections,
  extensions = { 'avante', 'lazy', 'mason' },
})
