local colors = require("colors")
local settings = require("settings")

-- #### Bar Appearance #####
-- Configuring the general appearance of the bar.
-- These are only some of the options available. For all options see:
-- https://felixkratz.github.io/SketchyBar/config/bar
Sbar.bar({
  color = colors.bar.bg,
  -- color = colors.transparent,
  -- color = colors.with_alpha(colors.black, 0.0),
  border_color = colors.bar.border,
  position = "top",
  height = 32,
  margin = 0,
  y_offset = 0,
  corner_radius = 0,
  border_width = 0,
  blur_radius = 20,
  padding_left = 10,
  padding_right = 10,
  topmost = "window",
  sticky = true,
  shadow = true,
})

-- #### Changing Defaults #####
-- We now change some default values, which are applied to all further items.
-- For a full list of all available item properties see:
-- https://felixkratz.github.io/SketchyBar/config/items
Sbar.default({
  padding_left = 5,
  padding_right = 5,
  icon = {
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    font = {
      family = settings.font.text,
      style = "Bold",
      size = 14.0,
    },
  },
  label = {
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    font = {
      family = settings.font.text,
      style = "Semibold",
      size = 13.0,
    },
  },
  updates = "when_shown",
  background = {
    border_width = 2,
    height = 26,
    corner_radius = 9,
  },
  popup = {
    blur_radius = 20,
    background = {
      color = colors.popup.bg,
      border_color = colors.popup.border,
      border_width = 2,
      corner_radius = 9,
      shadow = { drawing = true },
    },
  },
})
