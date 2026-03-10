# https://github.com/ryantm/agenix

{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.agenix.homeManagerModules.default
  ];

  home.packages = [
    inputs.agenix.packages.${pkgs.system}.default
  ];

  # Avoid agenix infinite restart loop on macOS by disabling KeepAlive entirely
  launchd.agents.activate-agenix.config.KeepAlive = lib.mkForce false;
}
