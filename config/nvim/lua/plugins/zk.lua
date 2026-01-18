-- ── References ──────────────────────────────────────────────────────
-- - https://github.com/zk-org/zk-nvim
-- - https://zk-org.github.io/zk/tips/editors-integration.html
-- - https://github.com/zk-org/zk-nvim/blob/main/lua/zk/commands/builtin.lua#L64-L68
-- - https://github.com/riodelphino/snacks-zk-explorer.nvim

---@type LazySpec
return {
  {
    'riodelphino/snacks-zk.nvim',
    enabled = false,
    dependencies = { 'folke/snacks.nvim', 'zk-org/zk-nvim' },
    config = function()
      require('snacks.picker.source.zk').setup({
        queries = {
          buffers = {
            desc = 'Buffers',
            input = function(_, _, cb)
              local paths = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                  local path = vim.api.nvim_buf_get_name(buf)
                  if path ~= '' then table.insert(paths, path) end
                end
              end
              cb({ desc = 'Buffers', query = { hrefs = paths } })
            end,
          },
        },
      })
    end,
  },
  {
    'zk-org/zk-nvim',
    main = 'zk',
    keys = {
      { '<leader>zo', '<Cmd>ZkNote<CR>', desc = 'Open/Create Note' },
      { '<leader>zd', '<Cmd>ZkDaily<CR>', desc = 'Daily Note' },
      { '<leader>zD', '<Cmd>ZkDailyNotes<CR>', desc = 'Daily Notes' },
      {
        '<leader>znt',
        ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
        mode = 'v',
        desc = 'New Note from Title Selection',
      },
      {
        '<leader>znc',
        ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
        mode = 'v',
        desc = 'New Note from Content Selection',
      },
      -- Filters
      { '<leader>zi', '<Cmd>ZkInbox<CR>', desc = 'Inbox Notes' },
      { '<leader>zR', '<Cmd>ZkResources<CR>', desc = 'Resource Notes' },
      { '<leader>zO', '<Cmd>ZkOrphans<CR>', desc = 'Orphaned Notes' },
      { '<leader>zr', '<Cmd>ZkRecents<CR>', desc = 'Recent Notes' },
      { '<leader>zt', '<Cmd>ZkTags<CR>', desc = 'Tags' },
      -- Navigate
      { '<leader>zb', '<Cmd>ZkBacklinks<CR>', desc = 'Back Links' },
      { '<leader>zl', '<Cmd>ZkLinks<CR>', desc = 'Links' },
      { '<leader>z,', '<Cmd>ZkBuffer<CR>', desc = 'Buffers' },
    },
    opts = function()
      require('which-key').add({ '<leader>z', group = 'Zk', icon = '󰠮' })

      local ret = {
        picker = 'snacks_picker',
        lsp = {
          config = {
            on_attach = function(client, _)
              -- use marksman lsp
              -- marksman lsp jump to the title
              client.server_capabilities.definitionProvider = false
              -- marksman lsp reference provider has column position
              client.server_capabilities.referencesProvider = false
              -- marksman lsp hover hide metadata
              client.server_capabilities.hoverProvider = false
            end,
          },
        },
      }

      local zk = require('zk')
      local commands = require('zk.commands')

      local function make_edit_fn(defaults, picker_options)
        return function(options)
          options = vim.tbl_extend('force', defaults, options or {})
          zk.edit(options, picker_options)
        end
      end

      commands.add(
        'ZkNote',
        make_edit_fn({ excludeHrefs = { 'daily' }, sort = { 'created' } }, {
          ---@type snacks.picker.Config
          snacks_picker = {
            win = {
              input = {
                keys = {
                  ['<C-e>'] = 'create',
                },
              },
            },
            actions = {
              create = function(picker)
                local title = picker.input:get()
                picker:close()
                vim.notify('Creating note: ' .. title)
                zk.new({ title = title })
              end,
            },
          },
        })
      )
      commands.add('ZkDaily', function(options)
        options =
          vim.tbl_extend('force', { dir = vim.env.ZK_NOTEBOOK_DIR .. '/daily' }, options or {})
        zk.new(options)
      end)
      commands.add(
        'ZkDailyNotes',
        make_edit_fn({ hrefs = { 'daily' }, sort = { 'title-' } }, { title = 'Zk Daily Notes' })
      )

      -- Filters
      commands.add('ZkInbox', make_edit_fn({ tags = { 'inbox' } }, { title = 'Zk Inbox Notes' }))
      commands.add(
        'ZkResources',
        make_edit_fn({ tags = { 'resource' } }, { title = 'Zk Resources' })
      )
      commands.add(
        'ZkOrphans',
        make_edit_fn({ excludeHrefs = { 'daily' }, orphan = true }, { title = 'Zk Orphans' })
      )
      commands.add(
        'ZkRecents',
        make_edit_fn(
          { createdAfter = '2 weeks ago', sort = { 'created' } },
          { title = 'Zk Recents' }
        )
      )

      commands.add('ZkBuffer', function()
        local paths = {}
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            local path = vim.api.nvim_buf_get_name(buf)
            if path ~= '' then table.insert(paths, path) end
          end
        end
        zk.edit({ hrefs = paths }, {
          title = 'Zk Buffers',
          ---@type snacks.picker.Config
          snacks_picker = {
            on_show = function() vim.cmd.stopinsert() end,
            layout = { preset = 'ivy', layout = { position = 'bottom' } },
            win = {
              input = {
                keys = {
                  ['d'] = 'deletezkbuf',
                },
              },
              list = { keys = { ['d'] = 'deletezkbuf' } },
            },
            actions = {
              deletezkbuf = function(picker)
                picker.preview:reset()
                local non_buf_delete_requested = false
                for _, item in ipairs(picker:selected({ fallback = true })) do
                  if item.file then
                    Snacks.bufdelete.delete({ file = item.file })
                  else
                    non_buf_delete_requested = true
                  end
                end
                if non_buf_delete_requested then
                  Snacks.notify.warn(
                    'Only open buffers can be deleted',
                    { title = 'Snacks Picker' }
                  )
                end
                picker:close()
                vim.cmd(':ZkBuffer')
              end,
            },
          },
        })
      end)

      return ret
    end,
  },
}
