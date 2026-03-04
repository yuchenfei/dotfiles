{
  inputs,
  outputs,
  pkgs,
  user,
  email,
  ...
}:

{
  imports = [
    ./homebrew.nix
    ./yabai.nix
  ];

  # fist time need run with --flake ~/.dotfiles
  environment.etc.nix-darwin.source = "/Users/${user}/.dotfiles";

  system = {
    defaults = {
      dock.autohide = true;
    };
  };

  # Use TouchID and WatchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;

  home-manager = {
    extraSpecialArgs = { inherit inputs user email; };
    users.${user} = {
      imports = [
        # inputs.catppuccin.homeModules.catppuccin
        ./home.nix
        outputs.homeManagerModules.default
      ];
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.NF-CN-unhinted
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ ];

  nix = {
    settings = {
      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
      warn-dirty = false;
      substitute = true;
      substituters = [
        "https://cache.nixos.org"
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 5;
          Minute = 15;
          Weekday = 7;
        }
      ];
      options = "--delete-older-than 7d";
    };
    # Automate `nix store --optimise`
    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 6;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
  };

  # Set Git commit hash for darwin-version.
  system.configurationRevision = outputs.rev or outputs.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
