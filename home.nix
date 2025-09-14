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
  home.packages = [
    pkgs.neovim
    pkgs.nixfmt-rfc-style
  ];

  programs.git = {
    enable = true;
    delta.enable = true;
    userName = "${user}";
    userEmail = "${email}";
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictStyle = "zdiff3";
      delta.navigate = true;
      delta.line-numbers = true;
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
      drs = "sudo darwin-rebuild switch --flake ~/.dotfiles/";
      ff = "fastfetch";
    };
  };

  catppuccin.starship.enable = false;
  home.file = {
    ".config/starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/starship.toml";
  };
  programs.starship.enable = true;

  programs.yazi = {
    enable = true;
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
    historyLimit = 5000;
    extraConfig = ''
      set -g status-position top
      set -g renumber-windows on

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
