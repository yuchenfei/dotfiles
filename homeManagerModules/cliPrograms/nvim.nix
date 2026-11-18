{
  config,
  pkgs,
  ...
}:
let
  linkConfig = import ../lib/link-config.nix config;
in
{
  home.packages = with pkgs; [
    neovim
    tree-sitter # CLI used by nvim-treesitter to install parsers
  ];

  xdg.configFile.nvim.source = linkConfig "nvim";

  # marksman global config
  #home.file."Library/Application Support/marksman/config.toml".text = ''
  #  [core]
  #  title_from_heading = false
  #'';
}
