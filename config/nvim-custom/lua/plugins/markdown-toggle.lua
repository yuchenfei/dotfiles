-- References:
--  - https://github.com/roodolv/markdown-toggle.nvim

---@type LazySpec
return {
  'roodolv/markdown-toggle.nvim',
  ft = { 'markdown' },
  opts = {
    use_default_keymaps = false,
    enable_autolist = false, -- use bullets.vim
    keymaps = {
      toggle = {
        ['<Leader>mh'] = 'heading',
        ['<Leader>mH'] = 'heading_toggle',
        ['<Leader>ml'] = 'list',
        ['<Leader>mo'] = 'olist',
        ['<Leader>mq'] = 'quote',
        ['<Leader>mx'] = 'checkbox',
      },
      switch = {
        ['<Leader>mL'] = 'switch_cycle_list_table',
        ['<Leader>mU'] = 'switch_unmarked_only',
        ['<Leader>mX'] = 'switch_cycle_box_table',
      },
    },
  },
}
