{ inputs, user, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    inherit user;
    enable = true;
    enableRosetta = true; # Apple Silicon Only
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "brewforge/homebrew-extras" = inputs.homebrew-extras;
      "daipeihust/homebrew-tap" = inputs.im-select;
      "oven-sh/homebrew-bun" = inputs.bun;
    };
    mutableTaps = false;
  };

}
