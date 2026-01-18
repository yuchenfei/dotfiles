local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local apple = Sbar.add("item", "apple", {
  padding_left = 1,
  padding_right = 1,
  icon = {
    padding_right = 8,
    padding_left = 8,
    font = { size = 16.0 },
    string = icons.apple,
  },
  label = {
    drawing = false,
  },
  background = {
    color = colors.bg2,
    border_color = colors.black,
    border_width = 1,
  },
  click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})

Sbar.add("bracket", { apple.name }, {
  background = {
    color = colors.transparent,
    border_color = colors.grey,
    border_width = 2,
    height = 28,
  },
})

Sbar.add("item", "apple.space", {
  width = settings.space,
})
