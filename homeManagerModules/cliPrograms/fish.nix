{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;

  launchFish = ''
    if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
    then
        exec fish -l
    fi
  '';
in
{
  programs = {
    zsh = lib.mkIf isDarwin {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh";
      initContent = launchFish;
    };

    bash = lib.mkIf isLinux {
      enable = true;
      bashrcExtra = launchFish;
    };

    fish = {
      enable = true;

      shellAbbrs = {
        nix-system-clean = "nix-wipe && nix-clean && nix-optimise";
      }
      // lib.optionalAttrs isDarwin {
        drs = "sudo darwin-rebuild switch";
      };

      shellAliases = {
        nix-history = "nix profile history --profile /nix/var/nix/profiles/system";
        nix-wipe = "sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system";
        nix-clean = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
        nix-optimise = "nix-store --optimise";
      };

      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        export BUN_INSTALL="$HOME/.bun"
        export PATH="$BUN_INSTALL/bin:$PATH"
      '';

      plugins = map (n: {
        name = n;
        inherit (pkgs.fishPlugins.${n}) src;
      }) [ "fzf-fish" ];
    };

    starship.enable = true;
  };

  catppuccin.starship.enable = false;
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/starship.toml";
}
