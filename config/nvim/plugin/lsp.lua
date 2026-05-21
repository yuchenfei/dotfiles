-- https://neovim.io/doc/user/lsp/

---@type table<string, vim.lsp.Config>
local servers = {
  -- See :help lspconfig-all
  -- Lua
  stylua = {},
  lua_ls = {}, -- lua-language-server
  -- Python
  ty = {},
  ruff = {},
}

local function load_lspconfig()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('lspconfig-load', { clear = true }),
  once = true,
  callback = load_lspconfig,
})

-- Remove default LSP keymaps
pcall(vim.keymap.del, { 'n', 'x' }, 'gra') -- vim.lsp.buf.code_action()
pcall(vim.keymap.del, 'n', 'gri') -- vim.lsp.buf.implementation()
pcall(vim.keymap.del, 'n', 'grn') -- vim.lsp.buf.rename()
pcall(vim.keymap.del, 'n', 'grr') -- vim.lsp.buf.references()
pcall(vim.keymap.del, 'n', 'grt') -- vim.lsp.buf.type_definition()
pcall(vim.keymap.del, 'n', 'grx') -- vim.lsp.codelens.run()
-- `gO` -> vim.lsp.buf.document_symbol()
-- CTRL-S (i) -> vim.lsp.buf.signature_help()
-- v_an and v_in fall back to LSP vim.lsp.buf.selection_range() if treesitter is not active.
-- `gx` handles textDocument/documentLink.

-- See :help lsp-attach
-- :lua =vim.lsp.get_clients()[1].server_capabilities
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    map('gD', function() Snacks.picker.lsp_declarations() end, 'Goto Declaration')
    map('gI', function() Snacks.picker.lsp_implementations() end, 'Goto Implementation')
    map('gd', function() Snacks.picker.lsp_definitions() end, 'Goto Definition')
    map('gr', function() Snacks.picker.lsp_references() end, 'Goto References')
    map('gy', function() Snacks.picker.lsp_type_definitions() end, 'Goto T[y]pe Definition')
    map('<leader>la', vim.lsp.buf.code_action, 'Code Action')
    map('<leader>lc', vim.lsp.codelens.run, 'Run Codelens')
    map('<leader>lf', vim.lsp.buf.format, 'Format')
    map('<leader>li', function() Snacks.picker.lsp_config() end, 'Lsp Info')
    map('<leader>lr', vim.lsp.buf.rename, 'Rename')
    map('<leader>ls', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
    map('<leader>lS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
    map(']]', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference', { 'n', 't' })
    map('[[', function() Snacks.words.jump(-vim.v.count1) end, 'Prev Reference', { 'n', 't' })

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    if client:supports_method('textDocument/inlayHint', event.buf) then
      map(
        '<leader>th',
        function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })) end,
        'Toggle Inlay Hints'
      )
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then return end
    if client.name == 'ruff' then
      -- Disable hover in favor of ty / pyright / basedpyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})

-- ╭─────────────────────────────────────────────────────────╮
-- │                    Diagnostic Config                    │
-- ╰─────────────────────────────────────────────────────────╯
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  -- Can switch between these as you prefer
  virtual_text = true, -- Text shows up at the end of the line
  virtual_lines = false, -- Text shows up underneath the line, with virtual lines

  -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      })
    end,
  },
})

vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
Snacks.toggle.diagnostics():map('<leader>td')
