{ user, pkgs, ... }:
{
  imports = [
    ../../homeManagerModules/cliPrograms/fd.nix
    ../../homeManagerModules/cliPrograms/gcc.nix
    ../../homeManagerModules/cliPrograms/git.nix
    ../../homeManagerModules/cliPrograms/home-manager.nix
    ../../homeManagerModules/cliPrograms/lua.nix
    ../../homeManagerModules/cliPrograms/nix.nix
    ../../homeManagerModules/cliPrograms/nvim.nix
    ../../homeManagerModules/cliPrograms/ripgrep.nix
  ];

  xdg.enable = true;

  home = {
    packages = with pkgs; [
      bash-language-server
    ];
    sessionVariables = {
      NVIM_PROFILE = "lite";
      EDITOR = "nvim";
    };
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";
  };

  programs.bash = {
    enable = true;
    shellAliases.hms = "home-manager switch";
  };
}
