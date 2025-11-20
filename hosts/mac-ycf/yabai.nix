_: {
  services.yabai = {
    enable = true;
    enableScriptingAddition = true; # SIP must be disabled
    config = {
      # https://github.com/koekeishiya/yabai/wiki/Configuration#configuration-file
      layout = "bsp";
      window_placement = "second_child";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 5;
      window_shadow = "on";
      window_opacity = "off";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.9";
      # for sketchybar
      external_bar = "all:32:0";
    };
    # grid=<rows>:<cols>:<start-x>:<start-y>:<width>:<height>
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      yabai -m rule --add app="(System Preferences|系统设置)" manage=off grid=4:6:2:0:2:3
      yabai -m rule --add app="(Finder|访达)" manage=off grid=20:20:1:1:18:18
      yabai -m rule --add app="(Preview|预览)" manage=off
      yabai -m rule --add app="(Music|音乐)" manage=off grid=10:10:1:1:8:8
      yabai -m rule --add app="(Calendar|日历)" manage=off grid=10:10:1:1:8:8

      yabai -m rule --add app="(Eudic|欧路词典)" manage=off grid=10:10:1:1:8:8
      yabai -m rule --add app="微信" manage=off grid=8:5:1:1:3:6
      yabai -m rule --add app="微信" title="^(视频通话.*)$" manage=off
    '';
  };
}
