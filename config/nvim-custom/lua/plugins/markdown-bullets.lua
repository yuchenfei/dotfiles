-- References:
--  - https://github.com/bullets-vim/bullets.vim

---@type LazySpec
return {
  'bullets-vim/bullets.vim',
  ft = { 'markdown' },
  init = function()
    -- Disable default key mappings
    vim.g.bullets_set_mappings = 0
    -- Customize key mappings
    vim.g.bullets_custom_mappings = {
      { 'imap', '<cr>', '<Plug>(bullets-newline)' },
      { 'inoremap', '<C-cr>', '<cr>' },
      { 'nmap', 'o', '<Plug>(bullets-newline)' },

      { 'vmap', 'gN', '<Plug>(bullets-renumber)' },
      { 'nmap', 'gN', '<Plug>(bullets-renumber)' },

      { 'imap', '<C-t>', '<Plug>(bullets-demote)' },
      { 'nmap', '>>', '<Plug>(bullets-demote)' },
      { 'vmap', '>', '<Plug>(bullets-demote)' },
      { 'imap', '<C-d>', '<Plug>(bullets-promote)' },
      { 'nmap', '<<', '<Plug>(bullets-promote)' },
      { 'vmap', '<', '<Plug>(bullets-promote)' },
    }
    -- Enable deleting the last empty bullet when hitting <cr> or 'o'
    vim.g.bullets_delete_last_bullet_if_empty = 2 -- 2 similar to Obsidian
    -- Don't add extra padding between the bullet and text when bullets are multiple characters long
    vim.g.bullets_pad_right = 0
    -- Nested outline bullet levels
    vim.g.bullets_outline_levels = { 'num' }
  end,
}
