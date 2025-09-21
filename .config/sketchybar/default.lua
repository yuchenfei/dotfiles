local settings = require("settings")
local colors = require("colors")

-- #### Changing Defaults #####
-- We now change some default values, which are applied to all further items.
-- For a full list of all available item properties see:
-- https://felixkratz.github.io/SketchyBar/config/items
--
-- Equivalent to the --default domain
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
