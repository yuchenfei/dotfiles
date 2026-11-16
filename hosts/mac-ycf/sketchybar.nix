{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    switchaudio-osx
  ];

  xdg.configFile.sketchybar.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/sketchybar";

  home.file = {
    "Library/Rime/lua/sketchybar_mode.lua".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/rime/lua/sketchybar_mode.lua";
    "Library/Rime/double_pinyin_flypy.custom.yaml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/rime/double_pinyin_flypy.custom.yaml";
  };

  programs.sketchybar = {
    enable = true;
    configType = "lua";
    extraPackages = with pkgs; [
      yabai
      switchaudio-osx
    ];
    service.enable = true;
  };
}
