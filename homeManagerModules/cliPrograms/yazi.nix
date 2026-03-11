# References:
# - https://wiki.nixos.org/wiki/Yazi
# - https://yazi-rs.github.io/docs/installation
# - https://github.com/nix-community/home-manager/blob/master/modules/programs/yazi.nix
# - https://search.nixos.org/packages?channel=unstable&query=yaziPlugins

{ inputs, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default;
    shellWrapperName = "y";
    plugins = {
      inherit (pkgs.yaziPlugins)
        git
        mediainfo
        piper
        smart-paste
        starship
        toggle-pane
        vcs-files
        ;
    };
    initLua = ''
      require("git"):setup()
      require("starship"):setup()
    '';
    settings = {
      mgr = {
        ratio = [
          1
          4
          4
        ];
      };
      preview = {
        wrap = "yes";
        max_width = 1500;
        max_height = 1500;
      };
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
        prepend_preloaders = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
        ];
        prepend_previewers = [
          {
            mime = "{audio,video,image}/*";
            run = "mediainfo";
          }
          {
            mime = "application/subrip";
            run = "mediainfo";
          }
          {
            mime = "application/postscript";
            run = "mediainfo";
          }
          {
            name = "*.md";
            run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
          }
          {
            name = "*/";
            run = ''piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes "$1"'';

          }
        ];
        append_previewers = [
          {
            name = "*";
            run = ''piper -- hexyl --border=none --terminal-width=$w "$1"'';
          }
        ];
      };
    };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "p";
          run = "plugin smart-paste";
          desc = "Paste into the hovered directory or CWD";
        }
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
        {
          on = [
            "g"
            "c"
          ];
          run = "plugin vcs-files";
          desc = "Show Git file changes";
        }
      ];
    };
  };
}
