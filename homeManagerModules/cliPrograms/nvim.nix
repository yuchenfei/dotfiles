{
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";

  linkConfig = name: {
    ".config/${name}".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/${name}";
  };

  configNames = [
    "nvim"
    "nvim-lazyvim"
  ];
in

{
  home.packages = with pkgs; [
    neovim
  ];

  home.file = lib.mkMerge (map linkConfig configNames);

  programs = {
    fish = {
      shellAliases = {
        lazyvim = ''NVIM_APPNAME="nvim-lazyvim" nvim'';
      };
    };
  };
}
