{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  xdg.configFile."home-manager/flake.nix" = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/flake.nix";
  };
}
