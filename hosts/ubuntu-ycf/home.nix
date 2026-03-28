{
  user,
  ...
}:
{
  imports = [
    ../../homeManagerModules/cliPrograms/common.nix
    ../../homeManagerModules/cliPrograms/fish.nix
  ];

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };

  programs.fastfetch.enable = true;
}
