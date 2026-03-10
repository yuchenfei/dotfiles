# https://github.com/nix-darwin/nix-darwin/blob/master/modules/services/yabai/default.nix
# https://github.com/asmvik/yabai/blob/master/src/misc/service.h
# launchctl print gui/$(id -u)/org.nixos.yabai
# launchctl kickstart -t gui/$(id -u)/org.nixos.yabai

{ user, ... }:
let
  errorLogFile = "/Users/${user}/Library/Logs/yabai/yabai.err.log";
  outLogFile = "/Users/${user}/Library/Logs/yabai/yabai.out.log";
in
{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true; # SIP must be disabled
    # config file defined in home.nix
  };

  launchd.user.agents.yabai.serviceConfig = {
    ProcessType = "Interactive";
    StandardErrorPath = errorLogFile;
    StandardOutPath = outLogFile;
  };
}
