{
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";

  linkConfig = name: {
    "${name}".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.config/${name}";
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

  # marksman global config
  home.file."Library/Application Support/marksman/config.toml".text = ''
    [core]
    title_from_heading = false
  '';

  xdg.configFile = lib.mkMerge (map linkConfig configNames);

  programs = {
    fish = {
      shellAliases = {
        lazyvim = ''NVIM_APPNAME="nvim-lazyvim" nvim'';
      };
    };
  };
}
