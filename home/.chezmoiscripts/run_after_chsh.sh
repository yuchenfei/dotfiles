#!/bin/bash

source "${CHEZMOI_WORKING_TREE}/scripts/utils.sh"

if command -v fish >/dev/null 2>&1; then
  if [ "$SHELL" != "$(which fish)" ]; then
    log_task "Changing default shell to fish"
    grep -qxF "$(which fish)" /etc/shells || which fish | sudo tee -a /etc/shells
    chsh -s "$(which fish)"
  fi
fi
