#!/usr/bin/env bash

SESSION="$1" # notes, config

ID="$(yabai -m query --windows | jq -r '[.[] | select(.app=="kitty" and (.title | test("^S:.+") | not) )][0].id')"

if [[ -z "$ID" || "$ID" == null ]]; then
  open -a "kitty"
  for _ in {1..10}; do
    ID="$(yabai -m query --windows | jq -r '[.[] | select(.app=="kitty" and (.title | test("^S:.+") | not) )][0].id')"
    if [[ -n "$ID" && "$ID" != null ]]; then
      break
    fi
    sleep 0.2
  done
fi

ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"
if [[ "$ID" == "$ID_CURRENT" && $(tmux display-message -p '#S') == "$SESSION" ]]; then
  skhd -k "cmd - h"
else
  yabai -m window --focus "$ID"
fi

if ! pgrep -x "tmux" >/dev/null; then
  sleep 0.6
  yabai -m window --focus "$ID"
  skhd -t "tmux"
  skhd -k "0x24"
  sleep 0.2
fi

switch_tmux_session() {
  local session_name="$1"
  local session_dir="$2"

  if ! tmux has-session -t "$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$session_dir" -- fish -i -c "cd $session_dir && nvim"
  fi
  tmux switch-client -t "$session_name"
}

if [[ "$SESSION" == "notes" ]]; then
  switch_tmux_session "notes" "~/Notes"
elif [[ "$SESSION" == "config" ]]; then
  switch_tmux_session "config" "~/.dotfiles"
else
  echo "Unknown session: $SESSION"
fi
