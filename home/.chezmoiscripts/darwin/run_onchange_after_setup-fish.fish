#!/opt/homebrew/bin/fish

if not type -q fisher
  echo -e "\e[0;32m>>>>> Installing Fisher <<<<<\e[0m"
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
end

# auto update when the plugins hash changes
# fish_plugins hash: {{ include "dot_config/private_fish/fish_plugins" | sha256sum }}
fisher update
