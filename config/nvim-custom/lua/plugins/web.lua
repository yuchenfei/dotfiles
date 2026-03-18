---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'css',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'tsx',
        'typescript',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        -- JSON schemas for Neovim
        -- https://github.com/b0o/SchemaStore.nvim
        'b0o/SchemaStore.nvim',
        lazy = true,
        version = false, -- last release is way too old
      },
    },
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      vim.tbl_deep_extend('force', opts.servers, {
        jsonls = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#jsonls
          -- https://github.com/b0o/SchemaStore.nvim
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },
      })
      return opts
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        html = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#html
        vtsls = {}, -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#vtsls
        biome = {
          -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#biome
          -- biome lsp is slower. https://github.com/LazyVim/LazyVim/issues/6496#issuecomment-3329781858
          enabled = false,
        },
      },
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        css = { 'biomejs' },
        html = { 'biomejs' },
        json = { 'biomejs' },
        jsonc = { 'biomejs' },
        javascript = { 'biomejs' },
        javascriptreact = { 'biomejs' },
        typescript = { 'biomejs' },
        typescriptreact = { 'biomejs' },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        css = { 'biome-check' },
        html = { 'biome-check' },
        json = { 'biome-check' },
        jsonc = { 'biome-check' },
        javascript = { 'biome-check' },
        javascriptreact = { 'biome-check' },
        typescript = { 'biome-check' },
        typescriptreact = { 'biome-check' },
      },
      formatters = {
        ['biome-check'] = {
          -- This config runs formatting, linting and import sorting.
          -- https://biomejs.dev/reference/cli/#biome-format
          args = function(self, ctx)
            if self:cwd(ctx) then
              return { 'check', '--write', '--stdin-file-path', '$FILENAME' }
            end
            -- only when biome.json{,c} don't exist
            return {
              'check',
              '--write',
              '--stdin-file-path',
              '$FILENAME',
              '--indent-style',
              'space',
              '--semicolons',
              'as-needed',
              '--javascript-formatter-quote-style',
              'single',
              '--html-formatter-enabled',
              'true',
            }
          end,
          condition = function()
            -- In biome project, prefer biome lsp than biome cli.
            if next(vim.lsp.get_clients({ name = 'biome' })) then return false end
            return true
          end,
        },
      },
    },
  },
  {
    'stevearc/overseer.nvim',
    opts = function()
      local overseer = require('overseer')
      -- Mask task background
      -- https://stackoverflow.com/a/79468088
      -- https://github.com/stevearc/overseer.nvim/blob/master/lua/overseer/vscode/init.lua#L219
      overseer.add_template_hook({ name = 'bun dev' }, function(task_defn, util)
        util.add_component(task_defn, {
          'on_output_parse',
          problem_matcher = {
            pattern = { regexp = '.', file = 1, location = 2, message = 3 },
            background = { activeOnStart = true, beginsPattern = '.', endsPattern = '.' },
          },
        })
        util.add_component(task_defn, { 'on_complete_restart' })
        util.add_component(task_defn, { 'unique' })
      end)
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = { ensure_installed = { 'js-debug-adapter' } },
      },
    },
    opts = function()
      local dap = require('dap')

      -- References:
      -- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua
      -- - https://github.com/microsoft/vscode-js-debug
      for _, adapterType in ipairs({ 'node', 'chrome', 'msedge' }) do
        local pwaType = 'pwa-' .. adapterType

        if not dap.adapters[pwaType] then
          dap.adapters[pwaType] = {
            type = 'server',
            host = 'localhost',
            port = '${port}',
            executable = {
              command = 'js-debug-adapter',
              args = { '${port}' },
            },
          }
        end

        -- Define adapters without the "pwa-" prefix for VSCode compatibility
        if not dap.adapters[adapterType] then
          dap.adapters[adapterType] = function(cb, config)
            local nativeAdapter = dap.adapters[pwaType]

            config.type = pwaType

            if type(nativeAdapter) == 'function' then
              nativeAdapter(cb, config)
            else
              cb(nativeAdapter)
            end
          end
        end
      end

      local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

      local vscode = require('dap.ext.vscode')
      vscode.type_to_filetypes['node'] = js_filetypes
      vscode.type_to_filetypes['pwa-node'] = js_filetypes

      for _, language in ipairs(js_filetypes) do
        if not dap.configurations[language] then
          local runtimeExecutable = nil
          if language:find('typescript') then
            runtimeExecutable = vim.fn.executable('tsx') == 1 and 'tsx' or 'ts-node'
          end
          dap.configurations[language] = {
            {
              type = 'pwa-node',
              request = 'launch',
              name = 'Launch file',
              program = '${file}',
              cwd = '${workspaceFolder}',
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = {
                '<node_internals>/**',
                'node_modules/**',
              },
              resolveSourceMapLocations = {
                '${workspaceFolder}/**',
                '!**/node_modules/**',
              },
            },
            {
              type = 'pwa-node',
              request = 'attach',
              name = 'Attach',
              processId = require('dap.utils').pick_process,
              cwd = '${workspaceFolder}',
              sourceMaps = true,
              runtimeExecutable = runtimeExecutable,
              skipFiles = {
                '<node_internals>/**',
                'node_modules/**',
              },
              resolveSourceMapLocations = {
                '${workspaceFolder}/**',
                '!**/node_modules/**',
              },
            },
            {
              type = 'pwa-chrome',
              request = 'launch',
              name = 'Launch Chrome (nvim-dap)',
              url = 'http://localhost:5173',
              webRoot = '${workspaceFolder}',
              sourceMaps = true,
              skipFiles = { '**/node_modules/**' },
              preLaunchTask = 'bun dev',
            },
            {
              type = 'pwa-msedge',
              request = 'launch',
              name = 'Launch Edge (nvim-dap)',
              url = 'http://localhost:5173',
              webRoot = '${workspaceFolder}',
              sourceMaps = true,
              skipFiles = { '**/node_modules/**' },
              preLaunchTask = 'bun dev',
            },
          }
        end
      end
    end,
  },
}
