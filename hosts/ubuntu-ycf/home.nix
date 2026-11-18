{
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../homeManagerModules/catppuccin.nix
    ../../homeManagerModules/cliPrograms/bat.nix
    ../../homeManagerModules/cliPrograms/curl.nix
    ../../homeManagerModules/cliPrograms/eza.nix
    ../../homeManagerModules/cliPrograms/fastfetch.nix
    ../../homeManagerModules/cliPrograms/fd.nix
    ../../homeManagerModules/cliPrograms/fish.nix
    ../../homeManagerModules/cliPrograms/fnm.nix
    ../../homeManagerModules/cliPrograms/fzf.nix
    ../../homeManagerModules/cliPrograms/gcc.nix
    ../../homeManagerModules/cliPrograms/git.nix
    ../../homeManagerModules/cliPrograms/home-manager.nix
    ../../homeManagerModules/cliPrograms/jq.nix
    ../../homeManagerModules/cliPrograms/lua.nix
    ../../homeManagerModules/cliPrograms/nix.nix
    ../../homeManagerModules/cliPrograms/nvim.nix
    ../../homeManagerModules/cliPrograms/ripgrep.nix
    ../../homeManagerModules/cliPrograms/tmux.nix
    ../../homeManagerModules/cliPrograms/uv.nix
    ../../homeManagerModules/cliPrograms/yazi.nix
    ../../homeManagerModules/cliPrograms/zoxide.nix
  ];

  home = {
    file.".terminfo".source = "${pkgs.kitty.terminfo}/share/terminfo";
    file.".terminfo".recursive = true;
    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "25.11";
  };
}
