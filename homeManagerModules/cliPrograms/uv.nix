_: {
  programs.uv.enable = true;

  programs.fish = {
    completions = {
      uv = "uv generate-shell-completion fish | source";
      uvx = "uvx --generate-shell-completion fish | source";
    };
  };
}
