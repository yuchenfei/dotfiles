mkdir /tmp/cover
rm -f /tmp/cover/cover-*
index=0
media-control stream |
  while IFS= read -r line; do
    if [ "$(jq -r '.diff == false' <<<"$line")" = "true" ]; then
      payload_empty=$(jq -r 'if (.payload | length) == 0 then "true" else "false" end' <<<"$line")
      if [ "$payload_empty" = "true" ]; then
        identifier="None"
        title=""
        artist=""
      else
        identifier=$(jq -r '.payload.bundleIdentifier' <<<"$line")
        title=$(jq -r '.payload.title' <<<"$line")
        artist=$(jq -r '.payload.artist' <<<"$line")
      fi

      echo "identifier: $identifier, title: $title, artist: $artist"
      sketchybar --trigger media_stream_changed identifier="$identifier" title="$title" artist="$artist"
    fi

    # Check for playback state changes
    if jq -e '.payload.playing != null' <<<"$line" >/dev/null; then
      playing=$(jq -r '.payload.playing' <<<"$line")
      sketchybar --trigger media_state_changed playing="$playing"
    fi

    # save artwork data to /tmp/cover/cover-<index>.<ext>
    if jq -e '.payload.artworkData' <<<"$line" >/dev/null; then
      jq -r '.payload.artworkData' <<<"$line" | base64 -d >/tmp/cover/cover
      filename="cover-$index.$(file -b /tmp/cover/cover | sed 's/ .*$//' | tr '[:upper:]' '[:lower:]')"
      mv /tmp/cover/cover "/tmp/cover/$filename"
      # Resize image to max 64x64 while preserving aspect ratio
      sips -Z 64 "/tmp/cover/$filename" >/dev/null 2>&1
      ((index++))
      sketchybar --trigger media_cover_changed cover="/tmp/cover/$filename"
    fi
  done
