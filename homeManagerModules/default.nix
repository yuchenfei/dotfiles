{ inputs, ... }:
{
  imports = [
    ./cliPrograms/common.nix
    ./cliPrograms/fastfetch.nix
    ./cliPrograms/fnm.nix
    ./cliPrograms/git.nix
    ./cliPrograms/nvim.nix
    ./cliPrograms/shell.nix
    ./cliPrograms/tmux.nix
    ./cliPrograms/uv.nix
    ./cliPrograms/yazi.nix
    ./guiPrograms/kitty.nix
    ./guiPrograms/sketchybar.nix
  ];
}
