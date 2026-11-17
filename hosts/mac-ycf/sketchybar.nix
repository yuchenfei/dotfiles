{ config, pkgs, ... }:
let
  linkConfig = import ../../homeManagerModules/lib/link-config.nix config;
in
{
  home.packages = with pkgs; [
    switchaudio-osx
  ];

  xdg.configFile.sketchybar.source = linkConfig "sketchybar";

  home.file = {
    "Library/Rime/lua/sketchybar_mode.lua".source = linkConfig "rime/lua/sketchybar_mode.lua";
    "Library/Rime/double_pinyin_flypy.custom.yaml".source =
      linkConfig "rime/double_pinyin_flypy.custom.yaml";
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
