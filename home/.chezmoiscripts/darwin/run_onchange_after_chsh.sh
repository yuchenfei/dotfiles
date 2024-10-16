#!/bin/bash

set -euo pipefail

if [ $SHELL != $(which fish) ]; then
  echo -e "\033[0;32m>>>>> Changing default shell to fish <<<<<\033[0m"
  chsh -s $(which fish)
fi
