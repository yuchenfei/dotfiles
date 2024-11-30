set -euo pipefail

function log_color() {
  local color=$1
  shift
  echo -e "\033[${color}m$@\033[0m"
}

function log_red() {
  log_color "0;31" "$@"
}

function log_green() {
  log_color "0;32" "$@"
}

function log_yellow() {
  log_color "0;33" "$@"
}

function log_task() {
  log_green ">>>>> $@ <<<<<"
}
