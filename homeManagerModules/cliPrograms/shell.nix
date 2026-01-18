{ pkgs, config, ... }:
{
  programs = {
    zsh = {
      enable = true;
      initContent = ''
        if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
        then
            exec fish -l
        fi
      '';
    };

    fish = {
      enable = true;
      shellAbbrs = {
        drs = "sudo darwin-rebuild switch";
        nix-system-clean = "nix-wipe && nix-clean && nix-optimise";
      };
      shellAliases = {
        nix-history = "nix profile history --profile /nix/var/nix/profiles/system";
        nix-wipe = "sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system";
        nix-clean = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
        nix-optimise = "nix-store --optimise";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        fish_add_path ~/.local/bin
        fish_add_path ~/.cache/.bun/bin
      '';
      plugins =
        map
          (n: {
            name = n;
            inherit (pkgs.fishPlugins.${n}) src;
          })
          [
            "fzf-fish"
          ];
    };

    starship.enable = true;
  };

  catppuccin.starship.enable = false;
  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/config/starship.toml";
}
