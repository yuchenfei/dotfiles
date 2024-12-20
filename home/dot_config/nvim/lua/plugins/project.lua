-- https://github.com/coffebar/neovim-project
return {
  {
    "coffebar/neovim-project",
    lazy = false,
    priority = 100,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "ibhagwan/fzf-lua" },
      { "Shatur/neovim-session-manager" },
    },
    keys = {
      { "<leader>fp", "<Cmd>NeovimProjectHistory<CR>", desc = "Projects (Recent)" },
      { "<leader>fP", "<Cmd>NeovimProjectDiscover<CR>", desc = "Projects" },
    },
    init = function()
      -- enable saving the state of plugins in the session
      vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    opts = {
      projects = {
        "~/Documents/Code/*/*",
      },
      last_session_on_startup = false,
      dashboard_mode = false,
      picker = {
        type = "fzf-lua",
      },
    },
  },
  {
    "folke/snacks.nvim",
    optional = true,
    opts = function(_, opts)
      table.insert(opts.dashboard.preset.keys, 3, {
        action = "<Cmd>NeovimProjectDiscover<CR>",
        desc = "Projects",
        icon = " ",
        key = "p",
      })
    end,
  },
}
