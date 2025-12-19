#!/usr/bin/env bash

SESSION="$1"

ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"

if [[ -z "$SESSION" ]]; then
  ID="$(yabai -m query --windows | jq -r '[.[] | select(.app=="kitty" and (.title | test("^S:.+") | not) )][0].id')"

  if [[ -n "$ID" && "$ID" == "$ID_CURRENT" ]]; then
    skhd -k "cmd - h"
    exit 0
  fi
  open -a "kitty"
else
  ID="$(yabai -m query --windows | jq -r --arg pattern "^S:$SESSION" '[.[] | select(.app=="kitty" and (.title | test($pattern)))][0].id')"
  echo "$ID"

  if [[ -n "$ID" && "$ID" != null ]]; then
    if [[ "$ID" == "$ID_CURRENT" ]]; then
      skhd -k "cmd - h"
      exit 0
    else
      yabai -m window --focus "$ID"
    fi
  else
    kitty \
      -o macos_quit_when_last_window_closed=yes \
      --session "~/.dotfiles/kitty/$SESSION.kitty-session"
  fi

fi
