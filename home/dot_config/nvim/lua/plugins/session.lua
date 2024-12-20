return {
  { "folke/persistence.nvim", enabled = false },
  {
    "Shatur/neovim-session-manager",
    keys = {
      {
        "<leader>qs",
        function() require("session_manager").load_current_dir_session() end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        function() require("session_manager").load_session(false) end,
        desc = "Select Session",
      },
      {
        "<leader>ql",
        function() require("session_manager").load_last_session() end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function() require("session_manager").delete_current_dir_session() end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
