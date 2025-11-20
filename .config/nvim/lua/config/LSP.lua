-- [[ LSP language specific config ]]
-- - https://github.com/neovim/nvim-lspconfig

-- vim.lsp.set_log_level('debug')

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
  settings = {
    Lua = {},
  },
})

-- - https://docs.basedpyright.com/latest/configuration/language-server-settings/
vim.lsp.config('basedpyright', {
  settings = {
    basedpyright = {
      -- Using Ruff's import organizer
      disableOrganizeImports = false,
    },
  },
})

local lsp_servers = {
  'basedpyright', -- Python https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#basedpyright
  'lua_ls', -- Lua https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
  'marksman', -- Markdown https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
  'nil_ls', -- Nix https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nil_ls
  -- 'pyrefly', -- Python https://github.com/neovim/nvim-lspconfig/blob/master/lsp/pyrefly.lua
  'vtsls', -- TypeScript https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
  -- biome lsp is slower. https://github.com/LazyVim/LazyVim/issues/6496#issuecomment-3329781858
  -- 'biome', -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#biome
}

for _, server in ipairs(lsp_servers) do
  vim.lsp.enable(server)
end

-- [[ Common LSP config ]]
--
-- References:
-- - https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

-- Disable default LSP keymaps
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    vim.keymap.del('n', 'gra')
    vim.keymap.del('n', 'grr')
    vim.keymap.del('n', 'grn')
    vim.keymap.del('n', 'gri')
    vim.keymap.del('n', 'grt')
    vim.keymap.del('n', 'gO')
  end,
})

-- See :help lsp-attach
-- :lua =vim.lsp.get_clients()[1].server_capabilities
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end

    -- Keymaps
    map('gd', function() Snacks.picker.lsp_definitions() end, 'LSP: Goto Definition')
    map('gD', function() Snacks.picker.lsp_declarations() end, 'LSP: Goto Declaration')
    map('gr', function() Snacks.picker.lsp_references() end, 'LSP: References')
    map('gI', function() Snacks.picker.lsp_implementations() end, 'LSP: Goto Implementation')
    map('gy', function() Snacks.picker.lsp_type_definitions() end, 'LSP: Goto T[y]pe Definition')
    map('gai', function() Snacks.picker.lsp_incoming_calls() end, 'LSP: Calls Incoming')
    map('gao', function() Snacks.picker.lsp_outgoing_calls() end, 'LSP: Calls Outgoing')
    map('K', function() return vim.lsp.buf.hover() end, 'LSP: Hover')
    map('gK', function() return vim.lsp.buf.signature_help() end, 'LSP: Signature Help')
    map('<c-k>', function() return vim.lsp.buf.signature_help() end, 'Signature Help', 'i')
    map('<leader>la', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
    map('<leader>lc', vim.lsp.codelens.run, 'Run Codelens', { 'n', 'x' })
    map('<leader>lC', vim.lsp.codelens.refresh, 'Refresh & Display Codelens')
    map('<leader>li', function() Snacks.picker.lsp_config() end, 'Lsp Info')
    map('<leader>lr', vim.lsp.buf.rename, 'Rename')
    map('<leader>lR', function() Snacks.rename.rename_file() end, 'Rename File')
    map('<leader>ls', function() Snacks.picker.lsp_symbols() end, 'LSP Symbols')
    map('<leader>lS', function() Snacks.picker.lsp_workspace_symbols() end, 'LSP Workspace Symbols')
    map(']]', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference', { 'n', 't' })
    map('[[', function() Snacks.words.jump(-vim.v.count1) end, 'Prev Reference', { 'n', 't' })
    map('<a-n>', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference', { 'n', 't' })
    map('<a-p>', function() Snacks.words.jump(-vim.v.count1) end, 'Prev Reference', { 'n', 't' })

    -- Highlight references of the word under cursor
    -- See :help CursorHold
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    if client:supports_method('textDocument/documentHighlight', event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end
  end,
})

-- [[ Diagnostics config ]]
local diagnostic_signs = {
  [vim.diagnostic.severity.ERROR] = '󰅚 ',
  [vim.diagnostic.severity.WARN] = '󰀪 ',
  [vim.diagnostic.severity.HINT] = '󰌶 ',
  [vim.diagnostic.severity.INFO] = '󰋽 ',
}

local shorter_source_names = {
  ['Lua Diagnostics.'] = 'Lua',
  ['Lua Syntax Check.'] = 'Lua',
}

local function diagnostic_format(diagnostic)
  return string.format(
    '%s %s: %s [%s]',
    diagnostic_signs[diagnostic.severity],
    shorter_source_names[diagnostic.source] or diagnostic.source,
    diagnostic.message,
    diagnostic.code
  )
end

local virtual_text_config = {
  -- severity = { min = 'INFO', max = 'WARN' },
  -- source = 'if_many',
  spacing = 2,
  prefix = '◍',
}

local virtual_lines_config = {
  -- severity = { min = 'ERROR' },
  current_line = true,
  format = diagnostic_format,
}

vim.keymap.set('n', '<leader>lk', function()
  vim.diagnostic.config({ virtual_lines = virtual_lines_config, virtual_text = false })
  vim.api.nvim_create_autocmd('CursorMoved', {
    group = vim.api.nvim_create_augroup('line-diagnostics', { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = virtual_text_config })
    end,
  })
end)

-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  -- underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = virtual_text_config,
  virtual_lines = false,
  signs = { text = diagnostic_signs },
  float = {
    header = '',
    -- source = true,
    format = diagnostic_format,
    suffix = '',
    border = 'rounded',
  },
  -- update_in_insert = true,
  severity_sort = true,
})

-- Commands
vim.api.nvim_create_user_command(
  'LspInfo',
  ':checkhealth vim.lsp',
  { desc = 'Alias to `:checkhealth vim.lsp`' }
)
vim.api.nvim_create_user_command(
  'LspLog',
  function() vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path())) end,
  { desc = 'Opens the Nvim LSP client log.' }
)
