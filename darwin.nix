{
  outputs,
  pkgs,
  config,
  user,
  ...
}:

{
  nix = {
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
    optimise = {
      # Automate `nix store --optimise`
      automatic = true;
      interval = [
        {
          Hour = 6;
          Minute = 15;
          Weekday = 7;
        }
      ];
    };
    settings = {
      # Necessary for using flakes on this system.
      experimental-features = "nix-command flakes";
      warn-dirty = false;
      substitute = true;
      substituters = [
        "https://yazi.cachix.org"
      ];
      trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.mkalias
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.NF-CN-unhinted
  ];

  users.users.${user} = {
    home = "/Users/${user}";
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  services.skhd.enable = true;
  services.yabai = {
    enable = true;
    enableScriptingAddition = true; # SIP must be disabled
    config = {
      # https://github.com/koekeishiya/yabai/wiki/Configuration#configuration-file
      layout = "bsp";
      window_placement = "second_child";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 5;
      window_shadow = "on";
      window_opacity = "off";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.9";
    };
    # grid=<rows>:<cols>:<start-x>:<start-y>:<width>:<height>
    extraConfig = ''
      yabai -m rule --add app="(System Preferences|系统设置)" manage=off grid=4:6:2:0:2:3
      yabai -m rule --add app="(Finder|访达)" manage=off grid=20:20:1:1:18:18
      yabai -m rule --add app="(Preview|预览)" manage=off
      yabai -m rule --add app="(Music|音乐)" manage=off grid=10:10:1:1:8:8
      yabai -m rule --add app="(Eudic|欧路词典)" manage=off grid=10:10:1:1:8:8
      yabai -m rule --add app="微信" manage=off grid=8:5:1:1:3:6
      yabai -m rule --add app="微信" title="^(视频通话.*)$" manage=off
    '';
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
