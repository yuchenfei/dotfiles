# References:
# - https://wiki.nixos.org/wiki/Yazi
# - https://github.com/nix-community/home-manager/blob/master/modules/programs/yazi.nix

{
  config,
  lib,
  pkgs,
  ...
}:
let
  linkConfig = import ../lib/link-config.nix config;
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
      source = linkConfig "yazi/${name}";
    }
  ) (builtins.readDir ../../config/yazi);

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    shellWrapperName = "y";
  };
}
