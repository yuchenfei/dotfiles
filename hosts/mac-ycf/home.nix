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

  configNames = [
    "skhd"
    "yabai"
    ".markdownlint-cli2.jsonc"
  ];
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
  };

  xdg.enable = true;
  xdg.configFile = lib.mkMerge (map linkConfig configNames);

  age = {
    identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
    secrets = {
      sshPrivateConfig = {
        file = ../../secrets/ssh-private-config.age;
        path = "${config.home.homeDirectory}/.ssh/ssh-private-config";
      };
      github = {
        file = ../../secrets/github.age;
        path = "${config.home.homeDirectory}/.ssh/github";
      };
      home = {
        file = ../../secrets/home.age;
        path = "${config.home.homeDirectory}/.ssh/home";
      };
      server = {
        file = ../../secrets/server.age;
        path = "${config.home.homeDirectory}/.ssh/server";
      };
    };
  };

  # https://github.com/nix-community/home-manager/blob/release-25.11/modules/programs/ssh.nix
  # https://man.openbsd.org/ssh_config
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    includes = [
      "~/.orbstack/ssh/config"
      config.age.secrets.sshPrivateConfig.path
    ];
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        controlMaster = "auto";
        controlPersist = "10m";
        forwardAgent = false;
        identitiesOnly = true;
        serverAliveInterval = 60;
        extraOptions = {
          UseKeychain = "yes";
        };
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.age.secrets.github.path;
      };
      router = {
        hostname = "immortalwrt.local";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      tower = {
        hostname = "tower.local";
        user = "root";
        identityFile = config.age.secrets.home.path;
      };
      ubuntu = {
        hostname = "ubuntu-ycf.local";
        user = "yuchenfei";
        identityFile = config.age.secrets.home.path;
      };
    };
  };

  services.skhd.enable = true;
}
