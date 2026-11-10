vim.pack.add({ { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' } })

---@type CatppuccinOptions
local opts = {
  transparent_background = true,
  integrations = {
    mason = true,
    snacks = true,
    which_key = true,
  },
}

require('catppuccin').setup(opts)

-- setup must be called before loading
vim.cmd.colorscheme('catppuccin')
