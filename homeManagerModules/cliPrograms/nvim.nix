{
  config,
  lib,
  pkgs,
  ...
}:
let
  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";

  linkConfig = name: {
    "${name}".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${name}";
  };
in

{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile = lib.mkMerge (
    map linkConfig [
      "nvim-custom"
      "nvim-lazyvim"
    ]
  );

  programs = {
    fish = {
      shellAliases = {
        lazyvim = ''NVIM_APPNAME="nvim-lazyvim" nvim'';
        nvimc = ''NVIM_APPNAME="nvim-custom" nvim'';
      };
    };
  };

  # marksman global config
  home.file."Library/Application Support/marksman/config.toml".text = ''
    [core]
    title_from_heading = false
  '';
}
