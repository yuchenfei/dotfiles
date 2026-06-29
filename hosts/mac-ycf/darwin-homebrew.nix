_: {
  homebrew = {
    enable = true;
    brews = [
      "bun" # tap
      "im-select" # tap
      "mas"
      "media-control"
      "mole"
      "socat"
      "tree-sitter-cli"
    ];
    casks = [
      "font-sf-mono"
      "font-sf-pro"
      "lyricsx-mxiris" # homebrew-extras
      "proxy-audio-device"
      "sf-symbols"
      "thaw"
    ];
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
  };
}
