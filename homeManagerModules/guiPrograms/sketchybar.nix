{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    switchaudio-osx
  ];

  programs.sketchybar = {
    enable = true;
    configType = "lua";
    extraPackages = [
      pkgs.yabai
      pkgs.switchaudio-osx
    ];
    service.enable = true;
  };
  xdg.configFile."sketchybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/sketchybar";
}
