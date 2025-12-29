#!/usr/bin/env bash

APP="$1"
APP_NAME="${2:-$APP}"

ID="$(yabai -m query --windows | jq -r --arg app "$APP_NAME" '[.[] | select(.app==$app)][0].id')"
ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"

if [[ -n "$ID" && "$ID" == "$ID_CURRENT" ]]; then
  skhd -k "cmd - h"
  sleep 0.1

  ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"
  if [[ "$ID" == "$ID_CURRENT" ]]; then
    skhd -k "cmd - m"
  fi
  exit 0
fi

open -a "$APP"
