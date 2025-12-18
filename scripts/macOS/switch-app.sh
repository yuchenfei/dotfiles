#!/usr/bin/env bash

APP="$1"
APP_NAME="${2:-$APP}"

ID="$(yabai -m query --windows | jq -r --arg app "$APP_NAME" '[.[] | select(.app==$app)][0].id')"
ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"

# echo "$APP_NAME ID: $ID"
# echo "Current ID: $ID_CURRENT"

if [[ -n "$ID" && "$ID" != null ]]; then
  if [[ "$ID_CURRENT" == "$ID" ]]; then
    skhd -k "cmd - h"
    exit 0
  fi
fi
open -a "$APP"
