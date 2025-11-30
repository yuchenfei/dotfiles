-- References:
-- - https://github.com/neovim/nvim-lspconfig
-- - https://github.com/mason-org/mason-lspconfig.nvim
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    { 'mason-org/mason-lspconfig.nvim', config = function() end },
  },
  event = 'VeryLazy',
  opts_extend = { 'servers.*.keys' },
  opts = {
    -- LSP Server Settings
    ---@alias lazyvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean }
    ---@type table<string, lazyvim.lsp.Config|boolean>
    servers = {
      lua_ls = { -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
        -- mason = false, -- set to false if you don't want this server to be installed with mason
        -- enabled = false, -- set to false if you don't want this server lsp to be enabled
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      },
      marksman = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#marksman
      nil_ls = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#nil_ls
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts: vim.lsp.Config):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
  },
  config = vim.schedule_wrap(function(_, opts)
    -- get all the servers that are available through mason-lspconfig
    local mason_all =
      vim.tbl_keys(require('mason-lspconfig.mappings').get_mason_map().lspconfig_to_package)
    local mason_exclude = {} ---@type string[]

    ---@return boolean? exclude automatic setup
    local function configure(server)
      if server == '*' then return false end
      local sopts = opts.servers[server]
      sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as lazyvim.lsp.Config]]

      if sopts.enabled == false then
        mason_exclude[#mason_exclude + 1] = server
        return
      end

      local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
      local setup = opts.setup[server] or opts.setup['*']
      if setup and setup(server, sopts) then
        mason_exclude[#mason_exclude + 1] = server
      else
        vim.lsp.config(server, sopts) -- configure the server
        if not use_mason then vim.lsp.enable(server) end
      end
      return use_mason
    end

    local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
    require('mason-lspconfig').setup({
      ensure_installed = install,
      automatic_enable = { exclude = mason_exclude },
    })

    -- vim.lsp.set_log_level('debug')

    -- [[ Common LSP config ]]
    --
    -- References:
    -- - https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
    -- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua

    -- See :help lsp-attach
    -- :lua =vim.lsp.get_clients()[1].server_capabilities
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        -- Disable default LSP keymaps
        pcall(vim.keymap.del, 'n', 'gra')
        pcall(vim.keymap.del, 'n', 'gri')
        pcall(vim.keymap.del, 'n', 'grn')
        pcall(vim.keymap.del, 'n', 'grr')
        pcall(vim.keymap.del, 'n', 'grt')
        pcall(vim.keymap.del, 'n', 'grt')
        pcall(vim.keymap.del, 'n', 'gO')

        -- Keymaps
        map('gd', function() Snacks.picker.lsp_definitions() end, 'LSP: Goto Definition')
        map('gD', function() Snacks.picker.lsp_declarations() end, 'LSP: Goto Declaration')
        map('gr', function() Snacks.picker.lsp_references() end, 'LSP: References')
        map('gI', function() Snacks.picker.lsp_implementations() end, 'LSP: Goto Implementation')
        map(
          'gy',
          function() Snacks.picker.lsp_type_definitions() end,
          'LSP: Goto T[y]pe Definition'
        )
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
        map(
          '<leader>lS',
          function() Snacks.picker.lsp_workspace_symbols() end,
          'LSP Workspace Symbols'
        )
        map(']]', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference', { 'n', 't' })
        map('[[', function() Snacks.words.jump(-vim.v.count1) end, 'Prev Reference', { 'n', 't' })
        map('<a-n>', function() Snacks.words.jump(vim.v.count1) end, 'Next Reference', { 'n', 't' })
        map(
          '<a-p>',
          function() Snacks.words.jump(-vim.v.count1) end,
          'Prev Reference',
          { 'n', 't' }
        )

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
        '%s %s: %s',
        diagnostic_signs[diagnostic.severity],
        shorter_source_names[diagnostic.source] or diagnostic.source,
        diagnostic.message
      ) .. (diagnostic.code and string.format(' [%s]', diagnostic.code) or '')
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
  end),
}
