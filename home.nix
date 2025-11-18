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
    # Image processing/manipulation
    imagemagick
    pngpaste

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
    # clang  # This will cause cargo install errors
    fnm
    gnumake
    neovim
    nixfmt-rfc-style
    statix
    uv
  ];

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nvim";

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
    # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
    # https://github.com/jesseduffield/lazygit/blob/master/docs/Custom_Pagers.md
    settings = {
      git.pagers = [
        {
          pager = "delta --dark --paging=never";
        }
      ];
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
    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      fish_add_path ~/.local/bin

      if type -q fastfetch
        fastfetch
      end

      if type -q fnm
        fnm env --use-on-cd --shell fish | source
      end
    '';
    completions = {
      uv = "uv generate-shell-completion fish | source";
      uvx = "uvx --generate-shell-completion fish | source";
    };
    plugins =
      map
        (n: {
          name = n;
          src = pkgs.fishPlugins.${n}.src;
        })
        [
          "fzf-fish"
        ];
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
      set -g default-terminal 'xterm-kitty'
      set -g renumber-windows on

      # yazi
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
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
    ];
  };
  catppuccin.tmux.extraConfig = ''
    # https://github.com/catppuccin/tmux/blob/main/catppuccin_options_tmux.conf

    set -g status-position top
    set -g status-justify absolute-centre

    set -g @catppuccin_status_background "none"

    #set -g @catppuccin_window_status_style "rounded"
    # https://github.com/catppuccin/tmux/issues/409#issuecomment-2894937794
    set -g @catppuccin_window_status_style "custom"
    set -g @catppuccin_window_left_separator "#[bg=default,fg=#{@thm_surface_0}]#[bg=#{@thm_surface_0},fg=#{@thm_fg}]"
    set -g @catppuccin_window_right_separator "#[bg=default,fg=#{@thm_surface_0}]"
    set -g @catppuccin_window_current_left_separator "#[bg=default,fg=#{@thm_mauve}]#[bg=#{@thm_mauve},fg=#{@thm_bg}]"
    set -g @catppuccin_window_current_middle_separator "#[fg=#{@thm_mauve}]█"
    set -g @catppuccin_window_current_right_separator "#[bg=default,fg=#{@thm_surface_1}]"

    set -g @catppuccin_window_text " #W"
    set -g @catppuccin_window_current_text " #W"
    set -g @catppuccin_window_flags "icon"

    set -g @catppuccin_directory_text " #{b:pane_current_path}"
    set -g status-left "#{E:@catppuccin_status_directory}"
    set -g status-left-length 100

    set -g @catppuccin_session_icon " "
    set -g status-right "#{E:@catppuccin_status_session}#{E:@catppuccin_status_host}"
    set -g status-right-length 100
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
      # "cmd+s" = "send_text all \e:w\\r";
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
