{ pkgs, ... }:
{
  home.packages = [ pkgs.fnm ];

  programs.fish = {
    interactiveShellInit = ''
      if type -q fnm
        fnm env --use-on-cd --shell fish | source
      end
    '';
  };
}
