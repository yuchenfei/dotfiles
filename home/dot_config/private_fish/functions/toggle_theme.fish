set light_theme Catppuccin-Latte
set dark_theme Catppuccin-Mocha
set light_flavour latte
set dark_flavour mocha

set kitty_config ~/.config/kitty/kitty.conf
set tmux_config ~/.config/tmux/tmux.conf
set nvim_config ~/.config/nvim/lua/config/options.lua

function set_nvim_bg
    set -l mode $argv[1]
    tmux list-panes -a -F '#{pane_id} #{pane_current_command}' |
        grep vim | # this captures vim and nvim
        cut -d ' ' -f 1 |
        xargs -I PANE tmux send-keys -t PANE Escape ":set background=$mode" Enter
end

function light_mode
    kitty +kitten themes --reload-in=all $light_theme
    sed -i '' s/$dark_flavour/$light_flavour/ $tmux_config
    sed -i '' s/dark/light/ $nvim_config
    set_nvim_bg light
    tmux source-file $tmux_config
end

function dark_mode
    kitty +kitten themes --reload-in=all $dark_theme
    sed -i '' s/$light_flavour/$dark_flavour/ $tmux_config
    sed -i '' s/light/dark/ $nvim_config
    set_nvim_bg dark
    tmux source-file $tmux_config
end

function toggle_theme
    set -l current_mode
    set -l mode

    if grep -q $light_theme $kitty_config
        set current_mode light
    else
        set current_mode dark
    end

    if test (count $argv) -gt 0
        set mode $argv[1]
    else
        if test $current_mode = light
            set mode dark
        else
            set mode light
        end
    end

    if test $mode = $current_mode
        return
    end

    if test $mode = light
        light_mode
    else if test $mode = dark
        dark_mode
    end
end
