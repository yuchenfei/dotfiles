-- https://github.com/stevearc/overseer.nvim/blob/master/doc/tutorials.md#run-a-file-on-save

return {
  name = "run script",
  condition = {
    filetype = { "sh", "python" },
  },
  builder = function()
    local cmd = {}
    if vim.bo.filetype == "sh" then
      cmd = { "bash" }
    elseif vim.bo.filetype == "python" then
      if vim.fn.executable("uv") then
        cmd = { "uv", "run" }
      else
        cmd = { "python3" }
      end
    end
    return {
      name = vim.fn.expand("%:t"),
      cmd = cmd,
      args = { vim.fn.expand("%:p") },
      components = {
        "default",
        "unique",
        "open_output",
      },
    }
  end,
}
