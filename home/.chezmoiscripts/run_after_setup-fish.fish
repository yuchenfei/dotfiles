#!/usr/bin/env fish

function install_fisher
    if not type -q fisher
        set_color green
        echo ">>>>> Installing Fisher <<<<<"
        set_color normal

        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    end
end

function install_fisher_plugin
    set -l plugin $argv[1]

    if not fisher ls | grep -q $plugin
        set_color green
        echo ">>>>> Installing Fisher Plugin: $plugin <<<<<"
        set_color normal
        fisher install $plugin
    end
end

install_fisher

install_fisher_plugin patrickf1/fzf.fish
