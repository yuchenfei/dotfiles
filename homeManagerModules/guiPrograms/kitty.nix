# https://home-manager-options.extranix.com/?query=kitty&release=master
# https://github.com/nix-community/home-manager/blob/master/modules/programs/kitty.nix

{
  config,
  lib,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";

  linkConfig = name: {
    "${name}".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${name}";
  };
in
{
  xdg.configFile = lib.mkMerge (
    map linkConfig [
      "kitty/settings.conf"
      "kitty/shortcuts.conf"
      "kitty/relative_resize.py"
    ]
  );
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
