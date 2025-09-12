{
  outputs,
  pkgs,
  config,
  user,
  ...
}:

{
  nix = {
    settings = {
      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
      substitute = true;
      substituters = [
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.mkalias
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.NF-CN-unhinted
  ];

  programs.zsh.enable = true;
  programs.fish.enable = true;
  services.skhd.enable = true;
  services.yabai.enable = true;

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
  };

  users.users.${user} = {
    home = "/Users/${user}";
  };

  system = {
    primaryUser = "${user}";
    defaults = {
      dock.autohide = true;
    };
  };

  # Use TouchID and WatchID for `sudo` authentication
  security.pam.services.sudo_local.touchIdAuth = true;
  security.pam.services.sudo_local.watchIdAuth = true;

  # https://gist.github.com/elliottminns/211ef645ebd484eb9a5228570bb60ec3
  system.activationScripts.applications.text =
    let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
    pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
    '';

  # Set Git commit hash for darwin-version.
  system.configurationRevision = outputs.rev or outputs.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
