---@type crates.UserConfig
local opts = {
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
}

local function crates_setup()
  vim.pack.add({ 'https://github.com/saecki/crates.nvim' })
  require('crates').setup(opts)
end

vim.api.nvim_create_autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('crates-setup', { clear = true }),
  pattern = 'Cargo.toml',
  once = true,
  callback = crates_setup,
})
