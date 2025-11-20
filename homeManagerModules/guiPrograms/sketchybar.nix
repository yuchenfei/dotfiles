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
    # config = {
    #   # config file need execute permissions
    #   source = ./.config/sketchybar;
    #   recursive = true;
    # };
    service.enable = true;
  };
  home.file.".config/sketchybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/sketchybar";
}
