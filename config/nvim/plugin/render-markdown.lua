---@type render.md.UserConfig
local opts = {
  anti_conceal = {
    ignore = {
      head_border = true,
      head_background = true,
    },
  },
  completions = { lsp = { enabled = true } },
  heading = {
    render_modes = true, -- Keep rendering while inserting
    icons = { '󰼏 ', '󰎨 ', '󰼑 ', '󰎲 ', '󰼓 ', '󰎴 ' },
    border = true,
  },
  code = {
    position = 'right',
    width = 'block',
    left_pad = 1,
    right_pad = 1,
    min_width = 80,
    border = 'thick',
  },
  checkbox = {
    unchecked = { icon = '󰄱', highlight = 'RenderMarkdownUnchecked', scope_highlight = 'RenderMarkdownUnchecked' },
    checked = { icon = '󰄵', highlight = 'RenderMarkdownChecked', scope_highlight = 'RenderMarkdownChecked' },
  },
  pipe_table = {
    preset = 'round',
  },
  link = {
    image = ' ',
    hyperlink = ' ',
    wiki = { icon = ' ', highlight = 'RenderMarkdownWikiLink', scope_highlight = 'RenderMarkdownWikiLink' },
  },
  sign = { enabled = false }, -- Turn off sign rendering
}

local function render_markdown_setup()
  vim.pack.add({ 'https://github.com/MeanderingProgrammer/render-markdown.nvim' })

  require('render-markdown').setup(opts)

  Snacks.toggle({
    name = 'Render Markdown',
    get = require('render-markdown').get,
    set = require('render-markdown').set,
  }):map('<leader>tm')
end

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('render-markdown-setup', { clear = true }),
  pattern = { 'markdown' },
  once = true,
  callback = render_markdown_setup,
})
