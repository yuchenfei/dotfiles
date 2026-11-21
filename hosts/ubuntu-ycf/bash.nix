{
  pkgs,
  lib,
  ...
}:
{
  home.file.".bash_profile".source = lib.mkForce (
    pkgs.writeText "bash_profile" ''
      case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) export PATH="$HOME/.local/bin:$PATH" ;;
      esac
      [[ -f ~/.profile ]] && . ~/.profile
      [[ -f ~/.bashrc ]] && . ~/.bashrc
    ''
  );

  # Hermes checks these files directly before attempting to append its PATH setup.
  programs.bash = {
    bashrcExtra = ''
      case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) export PATH="$HOME/.local/bin:$PATH" ;;
      esac
    '';
    profileExtra = ''
      case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) export PATH="$HOME/.local/bin:$PATH" ;;
      esac
    '';
  };
}
