#!/bin/bash

kitty \
  -o macos_quit_when_last_window_closed=yes \
  -o font_size=25 \
  -d ~/ \
  -- \
  fish -i -c 'yazi '"$1"
