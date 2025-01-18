return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept_word = "<C-w>",
          accept_line = "<C-l>",
          next = "<C-x>",
          prev = "<C-z>",
          dismiss = "<C-c>",
        },
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = {
      -- debug = true,
      -- log_level = "trace",
      prompts = {
        Spelling = { prompt = "Please correct any grammar and spelling errors in the following text." },
        Translation = { prompt = "请将文本翻译成中文" },
      },
    },
  },
}
