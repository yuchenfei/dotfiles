_: {
  homebrew = {
    enable = true;
    brews = [
      "bun" # tap
      "mas"
      "media-control"
      "mole"
      "pandoc"
      "socat"
      "tree-sitter-cli"
      {
        name = "daipeihust/tap/im-select";
        trusted = true;
      }
    ];
    casks = [
      "font-sf-mono"
      "font-sf-pro"
      "proxy-audio-device"
      "sf-symbols"
      "thaw"
      {
        name = "brewforge/extras/mxiris-lyricsx";
        trusted = true;
      }
    ];
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      # cleanup = "check";
    };
  };
}
