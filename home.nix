{
  config,
  pkgs,
  user,
  email,
  ...
}:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "${user}";
    homeDirectory = "/Users/${user}";
  };

  xdg.enable = true;

  catppuccin.enable = true;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # Battery management
    aldente

    # Networking
    doggo
    ifstat-legacy

    # Disk & file utilities
    dust
    gdu
    hexyl
    jless
    jq
    glow

    # Display & audio control
    monitorcontrol
    switchaudio-osx

    # Development tools
    neovim
    nixfmt-rfc-style
    clang
    gnumake
    fnm
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "${user}";
        email = "${email}";
      };
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      line-numbers = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };
    };
  };

  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.ripgrep.enable = true;
  programs.fzf.enable = true;
  programs.fastfetch.enable = true;
  programs.zsh = {
    enable = true;
    initContent = ''
      if [[ $(ps -o command= -p "$PPID" | awk '{print $1}') != 'fish' ]]
      then
          exec fish -l
      fi
    '';
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      if type -q fastfetch
        fastfetch
      end

      if type -q fnm
        fnm env --use-on-cd --shell fish | source
      end
    '';
    plugins =
      map
        (n: {
          name = n;
          src = pkgs.fishPlugins.${n}.src;
        })
        [
          "fzf-fish"
        ];
    shellAbbrs = {
      drs = "sudo darwin-rebuild switch";
      ff = "fastfetch";
      nix-system-clean = "nix-wipe && nix-clean && nix-optimise";
    };
    shellAliases = {
      nix-history = "nix profile history --profile /nix/var/nix/profiles/system";
      nix-wipe = "sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system";
      nix-clean = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
      nix-optimise = "nix-store --optimise";
    };
  };

  catppuccin.starship.enable = false;
  programs.starship.enable = true;
  home.file.".config/starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/starship.toml";

  programs.eza = {
    enable = true;
    icons = "auto";
    extraOptions = [
      "--group-directories-first"
      "--smart-group"
      "--color-scale"
      "--time-style"
      "iso"
    ];
  };

  programs.zoxide.enable = true;

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    plugins = builtins.listToAttrs (
      map
        (n: {
          name = n;
          value = pkgs.yaziPlugins.${n};
        })
        [
          "git"
          "piper"
          "smart-paste"
          "starship"
          "toggle-pane"
          "vcs-files"
        ]
    );
    initLua = ''
      require("git"):setup()
      require("starship"):setup()
    '';
    settings = {
      mgr = {
        show_hidden = true;
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
        prepend_previewers = [
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

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    reverseSplit = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    resizeAmount = 2;
    prefix = "C-space";
    mouse = true;
    focusEvents = true;
    escapeTime = 10;
    historyLimit = 10000;
    extraConfig = ''
      set -g status-position top
      set -g renumber-windows on
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded!"
      bind space last-window
      bind g choose-window 'join-pane -h -t "%%"'
      bind G choose-window 'join-pane -t "%%"'

      bind -T copy-mode-vi v   send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y   send -X copy-selection-and-cancel
      bind -T copy-mode-vi H   send -X start-of-line
      bind -T copy-mode-vi L   send -X end-of-line
    '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
    ];
  };
  catppuccin.tmux.extraConfig = ''
    set -g @catppuccin_window_status_style "rounded"

    set -g status-right-length 100
    set -g status-left ""
    set -g status-right "#{E:@catppuccin_status_application}#{E:@catppuccin_status_session}"
  '';

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    shellIntegration.enableFishIntegration = true;
    darwinLaunchOptions = [
      "--single-instance"
      "--listen-on=unix:/tmp/my-kitty-socket"
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
      "cmd+s" = "send_text all \e:w\\r";
    };
  };

  services.skhd.enable = true;
  home.file.".config/skhd/skhdrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/skhd/skhdrc";

  programs.sketchybar = {
    enable = true;
    configType = "lua";
    extraPackages = [
      pkgs.yabai
      pkgs.switchaudio-osx
    ];
    # config = {
    #   # config file need execute permissions
    #   source = ./.config/sketchybar;
    #   recursive = true;
    # };
    service.enable = true;
  };
  home.file.".config/sketchybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/sketchybar";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
