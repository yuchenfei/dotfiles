{
  pkgs,
  ...
}:
{
  programs.uv = {
    enable = true;
    package = pkgs.uv;
  };

  programs.fish = {
    completions = {
      uv = "uv generate-shell-completion fish | source";
      uvx = "uvx --generate-shell-completion fish | source";
    };
  };
}
