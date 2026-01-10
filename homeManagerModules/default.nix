{ inputs, ... }:
{
  imports = [
    ./cliPrograms/bun.nix
    ./cliPrograms/claude-code.nix
    ./cliPrograms/common.nix
    ./cliPrograms/fastfetch.nix
    ./cliPrograms/fnm.nix
    ./cliPrograms/gemini-cli.nix
    ./cliPrograms/git.nix
    ./cliPrograms/nix.nix
    ./cliPrograms/nvim.nix
    ./cliPrograms/shell.nix
    ./cliPrograms/tmux.nix
    ./cliPrograms/uv.nix
    ./cliPrograms/yazi.nix
    ./cliPrograms/zk.nix
    ./guiPrograms/chrome.nix
    ./guiPrograms/kitty.nix
    ./guiPrograms/sketchybar.nix
  ];
}
