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

  skhdPath = "${config.home.homeDirectory}/.dotfiles/.config/skhd";
  yabaiPath = "${config.home.homeDirectory}/.dotfiles/.config/yabai";
  markdownlintPath = "${config.home.homeDirectory}/.dotfiles/.config/.markdownlint-cli2.jsonc";
in
{
  home = {
    inherit packages;
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    ZK_NOTEBOOK_DIR = "${config.home.homeDirectory}/Notes";
  };

  xdg = {
    enable = true;
    configFile = {
      "skhd".source = config.lib.file.mkOutOfStoreSymlink skhdPath;
      "yabai".source = config.lib.file.mkOutOfStoreSymlink yabaiPath;
      ".markdownlint-cli2.jsonc".source = config.lib.file.mkOutOfStoreSymlink markdownlintPath;
    };
  };

  services.skhd.enable = true;
}
