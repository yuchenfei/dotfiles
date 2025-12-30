_: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    darwinLaunchOptions = [
      "--single-instance"
      "--listen-on=unix:/tmp/kitty-socket"
    ];
    font = {
      name = "Maple Mono NF CN";
      size = 20;
    };
    settings = {
      # https://sw.kovidgoyal.net/kitty/conf/
      # Fonts
      disable_ligatures = "cursor";
      # https://font.subf.dev/en/playground/
      "font_features MapleMono-NF-CN-Regular" = "+cv01 +ss05";
      "font_features MapleMono-NF-CN-SemiBold" = "+cv01 +ss05";
      "font_features MapleMono-NF-CN-Italic" = "+cv01 +ss05";
      "font_features MapleMono-NF-CN-SemiBoldItalic" = "+cv01 +ss05";
      # Text cursor customization
      cursor_trail = 20;
      cursor_trail_decay = "0.0 0.3";
      cursor_trail_start_threshold = 10;
      # Mouse
      copy_on_select = true;
      # Window layout
      remember_window_position = true;
      window_padding_width = "5 10";
      hide_window_decorations = "titlebar-only";
      # Tab bar
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      # Color scheme
      background_opacity = "0.8";
      background_blur = 30;
      # Advanced
      allow_remote_control = true;
      # OS specific tweaks
      macos_option_as_alt = "both";
    };
    keybindings = {
      # "cmd+s" = "send_text all \e:w\\r";
    };
  };
}
