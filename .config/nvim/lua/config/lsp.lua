-- [[ References ]]
-- https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

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
    map('<leader>ll', function() Snacks.picker.lsp_config() end, 'Lsp Info')
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

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
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
