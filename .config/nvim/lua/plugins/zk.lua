-- References:
-- - https://github.com/zk-org/zk-nvim
-- - https://zk-org.github.io/zk/tips/editors-integration.html

---@type LazySpec
return {
  'zk-org/zk-nvim',
  main = 'zk',
  dependencies = {
    {
      'folke/which-key.nvim',
      opts = {
        spec = {
          { '<leader>z', group = 'Zk', icon = '󰠮' },
        },
      },
    },
  },
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
    -- Links
    { '<leader>zb', '<Cmd>ZkBacklinks<CR>', desc = 'Back Links' },
    { '<leader>zl', '<Cmd>ZkLinks<CR>', desc = 'Links' },
  },
  opts = function()
    local ret = {
      picker = 'snacks_picker',
      lsp = {
        config = {
          on_attach = function(client, _)
            -- use marksman lsp
            -- marksman lsp reference provider has column position
            -- client.server_capabilities.referencesProvider = false
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

    ---@type snacks.picker.Config
    local snacks_picker = {
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
    }
    commands.add(
      'ZkNote',
      make_edit_fn(
        { excludeHrefs = { 'daily' }, sort = { 'created' } },
        { snacks_picker = snacks_picker }
      )
    )
    commands.add('ZkDaily', function(options)
      options =
        vim.tbl_extend('force', { dir = vim.env.ZK_NOTEBOOK_DIR .. '/daily' }, options or {})
      zk.new(options)
    end)
    commands.add(
      'ZkDailyNotes',
      make_edit_fn({ hrefs = { 'daily' }, sort = { 'title' } }, { title = 'Zk Daily Notes' })
    )

    -- Filters
    commands.add('ZkInbox', make_edit_fn({ tags = { 'inbox' } }, { title = 'Zk Inbox Notes' }))
    commands.add('ZkResources', make_edit_fn({ tags = { 'resource' } }, { title = 'Zk Resources' }))
    commands.add(
      'ZkOrphans',
      make_edit_fn({ excludeHrefs = { 'daily' }, orphan = true }, { title = 'Zk Orphans' })
    )
    commands.add(
      'ZkRecents',
      make_edit_fn({ createdAfter = '2 weeks ago', sort = { 'created' } }, { title = 'Zk Recents' })
    )
    return ret
  end,
}
