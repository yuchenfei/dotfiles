{ inputs, user, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    inherit user;
    enable = true;
    # Temporary: use a brew compatible with the pinned homebrew-core.
    # Remove with the homebrew-brew input once nix-homebrew's default catches up.
    package = inputs.homebrew-brew // {
      name = "brew-7.0.15";
      version = "7.0.15";
    };
    enableRosetta = true; # Apple Silicon Only
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "brewforge/homebrew-extras" = inputs.homebrew-extras;
      "daipeihust/homebrew-tap" = inputs.im-select;
      "oven-sh/homebrew-bun" = inputs.bun;
      "thaw-app/homebrew-tap" = inputs.thaw-tap;
    };
    mutableTaps = false;
  };

}
