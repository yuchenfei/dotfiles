# References:
# - https://wiki.nixos.org/wiki/Yazi
# - https://github.com/nix-community/home-manager/blob/master/modules/programs/yazi.nix

{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";
in
{
  home.packages = with pkgs; [
    glow
    hexyl
    imagemagick
    mediainfo
  ];

  xdg.configFile = lib.attrsets.mapAttrs' (
    name: _type:
    lib.nameValuePair "yazi/${name}" {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/yazi/${name}";
    }
  ) (builtins.readDir ../../config/yazi);

  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    shellWrapperName = "y";
  };
}
