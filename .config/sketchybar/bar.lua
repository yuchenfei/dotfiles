local colors = require("colors")

-- #### Bar Appearance #####
-- Configuring the general appearance of the bar.
-- These are only some of the options available. For all options see:
-- https://felixkratz.github.io/SketchyBar/config/bar
--
-- Equivalent to the --bar domain
Sbar.bar({
  color = colors.bar.bg,
  border_color = colors.bar.border,
  height = 32,
  blur_radius = 20,
  padding_left = 10,
  padding_right = 10,
  topmost = "window",
  sticky = true,
  shadow = true,
})
