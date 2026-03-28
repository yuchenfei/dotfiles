{
  user,
  ...
}:
{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  programs.fastfetch.enable = true;
}
