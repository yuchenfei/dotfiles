#!/usr/bin/env bash

SESSION="$1"

if [[ -z "$SESSION" ]]; then
  ID="$(yabai -m query --windows | jq -r '[.[] | select(.app=="kitty" and (.title | test("^S:.+") | not) )][0].id')"
else
  ID="$(yabai -m query --windows | jq -r --arg pattern "^S:$SESSION" '[.[] | select(.app=="kitty" and (.title | test($pattern)))][0].id')"
fi

if [[ -n "$ID" && "$ID" != null ]]; then
  ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"

  if [[ "$ID" == "$ID_CURRENT" ]]; then
    # if current window is the target window, hide it
    skhd -k "cmd - h"
  else
    # if exists, focus it
    yabai -m window --focus "$ID"
  fi
  exit 0
fi

if [[ -z "$SESSION" ]]; then
  open -a "kitty"
else
  kitty \
    -o macos_quit_when_last_window_closed=yes \
    --session "~/.dotfiles/kitty/$SESSION.kitty-session" &
fi
