_: {
  programs.fastfetch.enable = true;

  programs.fish = {
    shellAbbrs = {
      ff = "fastfetch";
    };
    interactiveShellInit = ''
      if type -q fastfetch
        fastfetch
      end
    '';
  };
}
