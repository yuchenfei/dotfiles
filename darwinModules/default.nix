{ user, ... }:
{
  imports = [
    ./home-manager.nix
    ./homebrew.nix
    ./fix-nix-apps-link.nix
  ];

  users.users.${user} = {
    home = "/Users/${user}";
  };

  system = {
    primaryUser = "${user}";
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;
}
