{ inputs, ... }:
{
  imports = [
    ./cliPrograms/agenix.nix
    ./cliPrograms/common.nix
    ./cliPrograms/fastfetch.nix
    ./cliPrograms/fnm.nix
    ./cliPrograms/git.nix
    ./cliPrograms/nix.nix
    ./cliPrograms/nvim.nix
    ./cliPrograms/fish.nix
    ./cliPrograms/tmux.nix
    ./cliPrograms/uv.nix
    ./cliPrograms/yazi.nix
    ./guiPrograms/chrome.nix
    ./guiPrograms/kitty.nix
    ./guiPrograms/sketchybar.nix
  ];
}
