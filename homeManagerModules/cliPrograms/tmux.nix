{ pkgs, ... }:
{
  # https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    resizeAmount = 2;
    prefix = "C-space";
    mouse = true;
    focusEvents = true;
    escapeTime = 10;
    historyLimit = 10000;
    # https://man.openbsd.org/OpenBSD-current/man1/tmux.1
    extraConfig = ''
      set -g default-terminal 'xterm-kitty'
      set -g renumber-windows on

      # yazi
      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reloaded!"

      bind -N "Switch to last session" space switch-client -l
      # -s starts with sessions collapsed
      # -w with windows collapsed
      # -Z zooms the pane
      # -O specifies the initial sort field: one of ‘index’, ‘name’, or ‘time’ (activity).
      bind -N "Choose a session from a list" e choose-tree -swZ -O time

      # Open panes in current directory
      bind -N "Split the pane into two, left and right" v split-window -h -c "#{pane_current_path}"
      bind -N "Split the pane into two, top and bottom" s split-window -v -c "#{pane_current_path}"

      bind -N "Join a pane to choised window horizontally" g choose-window 'join-pane -h -t "%%"'
      bind -N "Join a pane to choised window vertically" G choose-window 'join-pane -t "%%"'

      bind -N "Switch to last active window" ` last-window
      bind -N "Move current window to left" [ swap-window -t -1\; select-window -t -1
      bind -N "Move current window to right" ] swap-window -t +1\; select-window -t +1

      bind enter copy-mode
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
  # https://github.com/catppuccin/tmux/blob/main/catppuccin_options_tmux.conf
  catppuccin.tmux.extraConfig = ''
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
}
