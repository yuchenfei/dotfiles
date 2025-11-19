{ user, email, ... }:
{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "${user}";
          email = "${email}";
        };
        init.defaultBranch = "main";
        merge.conflictStyle = "zdiff3";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };

    lazygit = {
      enable = true;
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md
      settings = {
        git.pagers = [
          {
            pager = "delta --dark --paging=never";
          }
        ];
      };
    };
  };
}
