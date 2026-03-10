_: {
  homebrew = {
    enable = true;
    brews = [
      "bun" # tap
      "im-select" # tap
      "mas"
      "media-control"
    ];
    casks = [
      "font-sf-mono"
      "font-sf-pro"
      "font-sketchybar-app-font"
      "lyricsx-mxiris" # homebrew-extras
      "proxy-audio-device"
      "sf-symbols"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
