_: {
  homebrew = {
    enable = true;
    brews = [
      "bun" # tap
      "im-select" # tap
      "mas"
      "media-control"
      "mole"
    ];
    casks = [
      "font-sf-mono"
      "font-sf-pro"
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
