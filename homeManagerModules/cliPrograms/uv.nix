{
  pkgs-unstable,
  ...
}:
{
  programs.uv = {
    enable = true;
    package = pkgs-unstable.uv;
  };

  programs.fish = {
    completions = {
      uv = "uv generate-shell-completion fish | source";
      uvx = "uvx --generate-shell-completion fish | source";
    };
  };
}
