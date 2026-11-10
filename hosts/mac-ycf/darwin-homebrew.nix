_: {
  homebrew = {
    enable = true;
    brews = [
      "bun" # tap
      {
        name = "daipeihust/tap/im-select";
        trusted = true;
      }
      "mas"
      "media-control"
      "mole"
      "pandoc"
      "socat"
      "tree-sitter-cli"
    ];
    casks = [
      "font-sf-mono"
      "font-sf-pro"
      {
        name = "brewforge/extras/mxiris-lyricsx";
        trusted = true;
      }
      "proxy-audio-device"
      "sf-symbols"
      "thaw"
    ];
    onActivation = {
      autoUpdate = false;
      upgrade = true;
    };
  };
}
