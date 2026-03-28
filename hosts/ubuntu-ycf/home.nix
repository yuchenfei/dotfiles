{
  pkgs,
  user,
  ...
}:
let
  packages = with pkgs; [
    gcc
  ];
in
{
  imports = [
    ../../homeManagerModules/cliPrograms/common.nix
    ../../homeManagerModules/cliPrograms/fastfetch.nix
    ../../homeManagerModules/cliPrograms/fish.nix
    ../../homeManagerModules/cliPrograms/fnm.nix
    ../../homeManagerModules/cliPrograms/git.nix
    ../../homeManagerModules/cliPrograms/nix.nix
    ../../homeManagerModules/cliPrograms/nvim.nix
    ../../homeManagerModules/cliPrograms/tmux.nix
    ../../homeManagerModules/cliPrograms/uv.nix
    ../../homeManagerModules/cliPrograms/yazi.nix
  ];

  home = {
    inherit packages;
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };

  programs.fastfetch.enable = true;
}
