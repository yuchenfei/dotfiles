local colors = require("colors")
local settings = require("settings")

local function mouse_click(env)
  if env.BUTTON == "right" then
    Sbar.exec("yabai -m space --destroy " .. env.SID)
  else
    Sbar.exec("yabai -m space --focus " .. env.SID)
  end
end

local function space_selection(env)
  local color = env.SELECTED == "true" and colors.white or colors.bg2

  Sbar.set(env.NAME, {
    icon = { highlight = env.SELECTED },
    label = { highlight = env.SELECTED },
    background = { border_color = color },
  })
end

local spaces = {}
for i = 1, 10, 1 do
  local space = Sbar.add("space", "space." .. i, {
    associated_space = i,
    padding_left = 2,
    padding_right = 2,
    icon = {
      color = colors.white,
      highlight_color = colors.red,
      padding_left = 10,
      padding_right = 10,
      string = i,
      font = { family = settings.font.numbers },
    },
    label = {
      drawing = false,
      color = colors.grey,
      highlight_color = colors.white,
      padding_right = 20,
      y_offset = -1,
      font = "sketchybar-app-font:Regular:16.0",
    },
  })

  spaces[i] = space.name
  space:subscribe("space_change", space_selection)
  space:subscribe("mouse.clicked", mouse_click)
end

Sbar.add("bracket", spaces, {
  background = { color = colors.bg1, border_color = colors.bg2 },
})

local space_creator = Sbar.add("item", {
  associated_display = "active",
  padding_left = 10,
  padding_right = 8,
  icon = {
    string = "􀆊",
    font = {
      style = "Heavy",
      size = 16.0,
    },
  },
  label = { drawing = false },
})

space_creator:subscribe("mouse.clicked", function(_)
  Sbar.exec("yabai -m space --create")
end)
