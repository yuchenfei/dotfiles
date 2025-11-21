-- References:
-- - https://github.com/stevearc/conform.nvim
-- - https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md
-- - https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md
-- - https://www.reddit.com/r/neovim/comments/1j55o9c/share_your_custom_toggles_using_snacks_toggle/

local biome_cond = function()
  -- In biome project, prefer biome lsp than biome cli.
  if next(vim.lsp.get_clients({ name = 'biome' })) then return false end
  return true
end

require('conform').setup({
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    -- Text formats
    markdown = { 'prettier', 'markdownlint-cli2', 'injected' },
    yaml = { 'prettier' },
    -- Programming languages
    lua = { 'stylua' },
    nix = { 'nixfmt' }, -- Installed via nixpkgs
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
    -- Web
    html = { 'prettier' },
    css = { 'biome-check' },
    json = { 'biome-check' },
    jsonc = { 'biome-check' },
    javascript = { 'biome-check' },
    javascriptreact = { 'biome-check' },
    typescript = { 'biome-check' },
    typescriptreact = { 'biome-check' },
    -- Use the "*" filetype to run formatters on all filetypes.
    -- ['*'] = { 'codespell' },
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    -- ['_'] = { 'trim_whitespace' },
  },
  default_format_opts = {
    lsp_format = 'fallback',
  },
  formatters = {
    injected = {
      options = {
        ignore_errors = true,
        -- injected format always raise a lsp error: _changetracking.lua:154: Invalid buffer id:
        -- I thinks it's caused by making temp buffer for injected formatter.
        lang_to_ext = {
          python = '', -- HACK: this will not activate python lsp
        },
        lang_to_formatters = {
          python = { 'ruff_format', 'ruff_organize_imports' },
        },
      },
    },
    prettier = {
      -- https://prettier.io/docs/options
      prepend_args = { '--no-semi', '--single-quote', '--prose-wrap', 'always' },
    },
    biome = {
      -- https://biomejs.dev/reference/cli/#biome-format
      append_args = { '--semicolons', 'as-needed', '--javascript-formatter-quote-style', 'single' },
      condition = biome_cond,
    },
    ['biome-check'] = {
      -- This config runs formatting, linting and import sorting.
      args = function(self, ctx)
        if self:cwd(ctx) then return { 'check', '--write', '--stdin-file-path', '$FILENAME' } end
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
        }
      end,
      condition = biome_cond,
    },
    ['markdownlint-cli2'] = {
      condition = function(_, ctx)
        local diag = vim.tbl_filter(
          function(d) return d.source == 'markdownlint' end,
          vim.diagnostic.get(ctx.buf)
        )
        return #diag > 0
      end,
    },
  },
  -- There is a similar affordance for format_after_save, which uses BufWritePost.
  -- This is good for formatters that are too slow to run synchronously.
  format_after_save = function(bufnr)
    -- Disable autoformat on certain filetypes
    local ignore_filetypes = { 'c', 'cpp' }
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then return end
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match('/node_modules/') then return end
    -- ...additional logic...
    return {}
  end,
  notify_on_error = false,
})

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})
vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

Snacks.toggle
  .new({
    id = 'format_on_save',
    name = 'Auto Format (Global)',
    get = function() return not vim.g.disable_autoformat end,
    set = function(state) vim.g.disable_autoformat = not state end,
  })
  :map('<leader>tf')

Snacks.toggle
  .new({
    id = 'format_on_save_buffer',
    name = 'Auto Format (Buffer)',
    get = function() return not vim.b.disable_autoformat end,
    set = function(state) vim.b.disable_autoformat = not state end,
  })
  :map('<leader>tF')
