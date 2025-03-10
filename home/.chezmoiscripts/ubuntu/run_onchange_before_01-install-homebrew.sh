#!/bin/bash

source "${CHEZMOI_WORKING_TREE}/scripts/utils.sh"

function install_homebrew() {
  log_task "Installing Homebrew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >>~/.bashrc
  echo "eval \"\$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"" >>~/.bashrc

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
}

if ! brew -v &>/dev/null; then
  install_homebrew
fi
