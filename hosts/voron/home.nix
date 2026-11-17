{ user, pkgs, ... }:
{
  imports = [
    ../../homeManagerModules/cliPrograms/home-manager.nix
    ../../homeManagerModules/cliPrograms/nvim.nix
  ];

  xdg.enable = true;

  home = {
    packages = with pkgs; [
      ripgrep
      fd
      tree-sitter
      gcc
      # Only the configuration-maintenance language services and formatters.
      bash-language-server
      lua-language-server
      stylua
      nil
      nixfmt
    ];
    sessionVariables = {
      NVIM_PROFILE = "lite";
      EDITOR = "nvim";
    };
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";
  };

  programs.git.enable = true;
}
