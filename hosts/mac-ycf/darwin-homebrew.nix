_: {
  homebrew = {
    enable = true;
    taps = [ "homebrew/cask" ];
    brews = [
      "oven-sh/bun/bun"
      "mas"
      "media-control"
      "mole"
      "pandoc"
      "socat"
      {
        name = "daipeihust/tap/im-select";
        trusted = true;
      }
    ];
    casks = [
      "antigravity-cli"
      "font-sf-mono"
      "font-sf-pro"
      "proxy-audio-device"
      "sf-symbols"
      {
        name = "thaw-app/tap/thaw@2-beta";
        trusted = true;
      }
      {
        name = "brewforge/extras/mxiris-lyricsx";
        trusted = true;
      }
    ];
    onActivation = {
      autoUpdate = false;
      upgrade = true;
      cleanup = "uninstall";
    };
  };
}
