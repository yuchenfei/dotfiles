{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  packages = with pkgs; [
    # Media tools
    imagemagick
    mediainfo
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
    fx
    glow
    most

    # Display & audio control
    monitorcontrol

    # Development tools
    # clang  # This will cause cargo install errors
    gnumake
  ];

  dotfilesDir = "${config.home.homeDirectory}/.dotfiles";

  linkConfig = name: {
    "${name}".source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/config/${name}";
  };
in
{
  imports = [
    ./sketchybar.nix
    ./skhd.nix
    ./ssh.nix
  ];

  home = {
    inherit packages;
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.enable = true;
  xdg.configFile = lib.mkMerge (
    map linkConfig [
      ".markdownlint-cli2.jsonc"
      "sketchybar"
      "skhd"
      "yabai"
    ]
  );

  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
}
