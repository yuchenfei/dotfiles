{
  config,
  pkgs,
  user,
  ...
}:
let
  packages = with pkgs; [
    # Image processing/manipulation
    imagemagick
    pngpaste

    # Battery management
    aldente

    # Networking
    doggo
    ifstat-legacy

    # Disk & file utilities
    dust
    gdu
    hexyl
    jless
    glow

    # Display & audio control
    monitorcontrol

    # Development tools
    # clang  # This will cause cargo install errors
    gnumake
  ];
in
{
  home = {
    inherit packages;
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";
  };

  xdg.enable = true;

  services.skhd.enable = true;
  home.file.".config/skhd/skhdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/skhd/skhdrc";

  home.file.".config/.markdownlint-cli2.jsonc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/.markdownlint-cli2.jsonc";
}
