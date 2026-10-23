{ user, pkgs, ... }:
{
  imports = [ ../../homeManagerModules/cliPrograms/nvim.nix ];

  xdg.enable = true;

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "26.05";
    sessionVariables = {
      NVIM_PROFILE = "lite";
      EDITOR = "nvim";
    };
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
  };

  programs.git.enable = true;
  programs.home-manager.enable = true;
}
