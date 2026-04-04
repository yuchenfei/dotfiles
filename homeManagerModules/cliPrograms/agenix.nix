# https://github.com/ryantm/agenix

{
  inputs,
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
  # launchd.agents.activate-agenix.config.KeepAlive = lib.mkForce false;

  # The agenix launchd job is one-shot, so rerun it explicitly after each
  # Home Manager switch to refresh copied secrets.
  # home.activation.activateAgenixAfterSwitch = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   if [ -f "$HOME/Library/LaunchAgents/org.nix-community.home.activate-agenix.plist" ]; then
  #     /bin/launchctl kickstart -k "gui/$UID/org.nix-community.home.activate-agenix" >/dev/null 2>&1 || true
  #   fi
  # '';
}
