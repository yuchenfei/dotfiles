{ config, ... }:
let
  linkConfig = import ../../homeManagerModules/lib/link-config.nix config;
in
{
  services.skhd.enable = true;

  xdg.configFile."skhd".source = linkConfig "skhd";
}
