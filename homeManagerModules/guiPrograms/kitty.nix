# https://home-manager-options.extranix.com/?query=kitty&release=master
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix

{
  config,
  lib,
  ...
}:
let
  linkConfig = import ../lib/link-config.nix config;
in
{
  xdg.configFile =
    lib.genAttrs
      [
        "kitty/settings.conf"
        "kitty/shortcuts.conf"
        "kitty/relative_resize.py"
      ]
      (name: {
        source = linkConfig name;
      });

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    darwinLaunchOptions = [
      "--single-instance"
      "--listen-on=unix:/tmp/kitty-socket"
    ];
    extraConfig = ''
      include settings.conf
      include shortcuts.conf
    '';
  };
}
