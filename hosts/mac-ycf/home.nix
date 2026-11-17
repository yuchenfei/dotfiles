{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  linkConfig = import ../../homeManagerModules/lib/link-config.nix config;
in
{
  imports = [
    ../../homeManagerModules/catppuccin.nix
    ../../homeManagerModules/cliPrograms/agenix.nix
    ../../homeManagerModules/cliPrograms/bat.nix
    ../../homeManagerModules/cliPrograms/btop.nix
    ../../homeManagerModules/cliPrograms/eza.nix
    ../../homeManagerModules/cliPrograms/fastfetch.nix
    ../../homeManagerModules/cliPrograms/fd.nix
    ../../homeManagerModules/cliPrograms/fish.nix
    ../../homeManagerModules/cliPrograms/fnm.nix
    ../../homeManagerModules/cliPrograms/fzf.nix
    ../../homeManagerModules/cliPrograms/git.nix
    ../../homeManagerModules/cliPrograms/home-manager.nix
    ../../homeManagerModules/cliPrograms/jq.nix
    ../../homeManagerModules/cliPrograms/nix.nix
    ../../homeManagerModules/cliPrograms/nvim.nix
    ../../homeManagerModules/cliPrograms/ripgrep.nix
    ../../homeManagerModules/cliPrograms/tmux.nix
    ../../homeManagerModules/cliPrograms/uv.nix
    ../../homeManagerModules/cliPrograms/yazi.nix
    ../../homeManagerModules/cliPrograms/zoxide.nix
    ../../homeManagerModules/guiPrograms/kitty.nix

    ./sketchybar.nix
    ./skhd.nix
    ./ssh.nix
  ];

  home = {
    packages = with pkgs; [
      # Media tools
      pngpaste

      # Battery management
      aldente

      # Networking
      doggo
      ifstat-legacy

      # Disk & file utilities
      dust
      gdu
      jless
      fx
      most

      # Display & audio control
      monitorcontrol

      # Development tools
      # clang  # This will cause cargo install errors
      gnumake
    ];
    sessionVariables = {
      EDITOR = "nvim";
      BUN_INSTALL = "$HOME/.bun";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.bun/bin"
      "/Applications/Obsidian.app/Contents/MacOS"
    ];
    username = "${user}";
    homeDirectory = "/Users/${user}";
    stateVersion = "25.05";
  };

  xdg.enable = true;
  xdg.configFile =
    lib.genAttrs
      [
        ".markdownlint-cli2.jsonc"
        "yabai"
      ]
      (name: {
        source = linkConfig name;
      });

  age.identityPaths = [ "${config.home.homeDirectory}/.ssh/id_ed25519" ];
}
