{ pkgs, ... }:
{
  home.packages = with pkgs; [
    switchaudio-osx
  ];

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
