#!/opt/homebrew/bin/fish

if not type -q fisher
  set_color green
  echo ">>>>> Installing Fisher <<<<<"
  set_color normal

  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

# auto update when the plugins hash changes
# fish_plugins hash: {{ include "dot_config/private_fish/fish_plugins" | sha256sum }}
fisher update
