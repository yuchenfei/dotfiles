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

    ./bash.nix
  ];

  home = {
    packages = with pkgs; [
      gnumake
      maple-mono.NF-CN-unhinted
    ];
    file.".terminfo".source = "${pkgs.kitty.terminfo}/share/terminfo";
    file.".terminfo".recursive = true;
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionPath = [ "$HOME/.local/bin" ];
    stateVersion = "25.11";
  };

  fonts.fontconfig.enable = true;

  xdg.enable = true;

  # The Hermes-generated service sets PATH explicitly and never reads shell profiles.
  # Keep its runtime tools available while adding the stable Nix profile paths.
  xdg.configFile."systemd/user/hermes-gateway.service.d/nix-path.conf".text = ''
    [Service]
    Environment="PATH=/home/${user}/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/home/${user}/.hermes/hermes-agent/node_modules/.bin:/home/${user}/.hermes/tools/node-26.12.1-linux-x64/bin:/home/${user}/.hermes/tools/npm-12.2.2-linux-x64/bin:/home/${user}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  '';

  programs.fish.completions.hermes = ''
    if command -sq hermes
      hermes completion fish | source
    end
  '';
}
