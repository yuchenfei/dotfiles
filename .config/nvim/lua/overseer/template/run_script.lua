-- https://github.com/stevearc/overseer.nvim/blob/master/doc/tutorials.md#run-a-file-on-save

---@type overseer.TemplateFileDefinition
return {
  name = 'run script',
  builder = function()
    local file = vim.fn.expand('%:p')
    local cmd = { file }
    if vim.bo.filetype == 'sh' then
      cmd = { 'bash', file }
    elseif vim.bo.filetype == 'python' then
      if vim.fn.executable('uv') then
        cmd = { 'uv', 'run', file }
      else
        cmd = { 'python3', file }
      end
    end
    return {
      cmd = cmd,
      components = {
        'default',
        'unique',
        'open_output',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'python' },
  },
}
