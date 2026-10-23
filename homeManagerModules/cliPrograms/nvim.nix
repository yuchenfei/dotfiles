{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    neovim
  ];

  xdg.configFile.nvim.source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/nvim";

  # marksman global config
  #home.file."Library/Application Support/marksman/config.toml".text = ''
  #  [core]
  #  title_from_heading = false
  #'';
}
