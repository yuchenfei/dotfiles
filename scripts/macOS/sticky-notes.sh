TITLE="S:sticky-notes"
WIDTH=280
HEIGHT=640
PADDING=10
BAR_HEIGHT=32

ID="$(yabai -m query --windows | jq -r --arg title "$TITLE" '[.[] | select(.app=="kitty" and .title==$title)][0].id')"

focus_sticky_notes() {
  DISPLAY_ID="$(yabai -m query --spaces --space main | jq -r '.display')"
  DISPLAY_INFO="$(yabai -m query --displays --display "$DISPLAY_ID")"
  DISPLAY_WIDTH="$(echo "$DISPLAY_INFO" | jq -r '.frame | with_entries(.value|=floor) | .w')"
  DISPLAY_HEIGHT="$(echo "$DISPLAY_INFO" | jq -r '.frame | with_entries(.value|=floor) | .h')"

  yabai -m config --space main right_padding $WIDTH

  yabai -m window --focus "$ID" --move abs:$((DISPLAY_WIDTH - WIDTH + PADDING)):$((BAR_HEIGHT + PADDING))
  yabai -m window --focus "$ID" --resize abs:$((WIDTH - PADDING * 2)):$HEIGHT
}

if [[ -n "$ID" && "$ID" != null ]]; then
  ID_CURRENT="$(yabai -m query --windows --window | jq -r '.id')"
  if [[ "$ID" == "$ID_CURRENT" ]]; then
    skhd -k "cmd - h"
    yabai -m config --space main right_padding $PADDING
  else
    focus_sticky_notes
  fi
  exit 0
fi

kitty \
  -o macos_quit_when_last_window_closed=yes \
  -o font_size=10 \
  -d ~/Notes \
  -T $TITLE \
  -- \
  fish -i -c "nvim" &

for _ in {1..10}; do
  ID="$(yabai -m query --windows | jq -r --arg title "$TITLE" '[.[] | select(.app=="kitty" and .title==$title)][0].id')"
  if [[ -n "$ID" && "$ID" != null ]]; then
    focus_sticky_notes
    break
  fi
  sleep 0.2
done
