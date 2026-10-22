{ user, ... }:
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";
  };

  programs.git.enable = true;
  programs.home-manager.enable = true;
}
