{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "yuchenfei";
  home.homeDirectory = "/Users/yuchenfei";

  xdg.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.neovim
    pkgs.nixfmt-rfc-style
  ];

  catppuccin.enable = true;

  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "yuchenfei";
    userEmail = "cf.yu@qq.com";
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      delta.navigate = true;
      delta.line-numbers = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };

  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.fish = {
    enable = true;
    plugins =
      map
        (n: {
          name = n;
          src = pkgs.fishPlugins.${n}.src;
        })
        [
          "fzf-fish"
        ];
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
