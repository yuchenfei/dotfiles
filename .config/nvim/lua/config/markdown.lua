-- https://github.com/MeanderingProgrammer/render-markdown.nvim

require('render-markdown').setup({
  file_types = { 'markdown', 'Avante' },
  anti_conceal = {
    -- disabled_modes = { 'n' },
    ignore = {
      head_border = true,
      head_background = true,
    },
  },
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/509
  -- win_options = { concealcursor = { rendered = 'nvc' } },
  completions = {
    blink = { enabled = false },
    lsp = { enabled = true },
  },
  heading = {
    render_modes = true,
    sign = false,
    -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    -- icons = { '󰉫 ', '󰉬 ', '󰉭 ', '󰉮 ', '󰉯 ', '󰉰 ' },
    icons = { '󰼏 ', '󰎨 ', '󰼑 ', '󰎲 ', '󰼓 ', '󰎴 ' },
    border = true,
    -- border_virtual = true,
  },
  code = {
    sign = false,
    position = 'right',
    width = 'block',
    min_width = 80,
    left_pad = 1,
    right_pad = 1,
    border = 'thick', -- thick | thin
    highlight_inline = 'RenderMarkdownCodeInfo',
  },
  bullet = {
    icons = { '●', '○', '◆', '◇' },
  },
  checkbox = {
    bullet = true,
    unchecked = {
      icon = '󰄱 ',
      highlight = 'RenderMarkdownUnchecked',
      scope_highlight = 'RenderMarkdownUnchecked',
    },
    checked = {
      icon = '󰱒 ',
      highlight = 'RenderMarkdownChecked',
      scope_highlight = 'RenderMarkdownChecked',
    },
    -- stylua: ignore
    custom = {
      canceled = { raw = '[~]',  rendered = ' ', highlight = 'RenderMarkdownCodeFallback', scope_highlight = '@text.strike' },
      favorite = { raw = '[>]',  rendered = ' ', highlight = 'RenderMarkdownMath',         scope_highlight = 'RenderMarkdownMath' },
      important = { raw = '[!]', rendered = ' ', highlight = 'RenderMarkdownWarn',         scope_highlight = 'RenderMarkdownWarn' },
      question = { raw = '[?]',  rendered = ' ', highlight = 'RenderMarkdownError',        scope_highlight = 'RenderMarkdownError' },
      todo = { raw = '[-]',      rendered = '󰦖 ', highlight = 'RenderMarkdownInfo',         scope_highlight = 'RenderMarkdownInfo' },
    },
  },
  pipe_table = {
    preset = 'round',
  },
  -- stylua: ignore
  callout = {
    warning   = { raw = '[!WARNING]',   rendered = ' Warning',   highlight = 'RenderMarkdownWarn',  category = 'github'   },
    abstract  = { raw = '[!ABSTRACT]',  rendered = '󰯂 Abstract',  highlight = 'RenderMarkdownInfo',  category = 'obsidian' },
    summary   = { raw = '[!SUMMARY]',   rendered = '󰯂 Summary',   highlight = 'RenderMarkdownInfo',  category = 'obsidian' },
    tldr      = { raw = '[!TLDR]',      rendered = '󰦩 Tldr',      highlight = 'RenderMarkdownInfo',  category = 'obsidian' },
    todo      = { raw = '[!TODO]',      rendered = '󰄰 Todo',      highlight = 'RenderMarkdownInfo',  category = 'obsidian' },
    attention = { raw = '[!ATTENTION]', rendered = ' Attention', highlight = 'RenderMarkdownWarn',  category = 'obsidian' },
    failure   = { raw = '[!FAILURE]',   rendered = ' Failure',   highlight = 'RenderMarkdownError', category = 'obsidian' },
    fail      = { raw = '[!FAIL]',      rendered = ' Fail',      highlight = 'RenderMarkdownError', category = 'obsidian' },
    missing   = { raw = '[!MISSING]',   rendered = ' Missing',   highlight = 'RenderMarkdownError', category = 'obsidian' },
    danger    = { raw = '[!DANGER]',    rendered = '󰈸 Danger',    highlight = 'RenderMarkdownError', category = 'obsidian' },
    error     = { raw = '[!ERROR]',     rendered = '󰈸 Error',     highlight = 'RenderMarkdownError', category = 'obsidian' },
    quote     = { raw = '[!QUOTE]',     rendered = ' Quote',     highlight = 'RenderMarkdownQuote', category = 'obsidian' },
    cite      = { raw = '[!CITE]',      rendered = ' Cite',      highlight = 'RenderMarkdownQuote', category = 'obsidian' },
    wip       = { raw = '[!WIP]',       rendered = '󰦖 WIP',       highlight = 'RenderMarkdownHint',  category = 'obsidian' },
  },
  link = {
    image = ' ',
    hyperlink = ' ',
    wiki = {
      icon = ' ',
      highlight = 'RenderMarkdownWikiLink',
      scope_highlight = 'RenderMarkdownWikiLink',
    },
    custom = {
      github = { pattern = 'github', icon = '󰊤 ' },
      gitlab = { pattern = 'gitlab', icon = '󰮠 ' },
      youtube = { pattern = 'youtube', icon = '󰗃 ' },
    },
  },
})
