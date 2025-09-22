local settings = require("settings")

local cal = Sbar.add("item", {
  position = "right",
  padding_left = 1,
  padding_right = 1,
  icon = {
    padding_right = 0,
    font = {
      style = "Black",
      size = 12.0,
    },
  },
  label = {
    font = { family = settings.font.numbers },
    width = 49,
    align = "right",
  },
  update_freq = 30,
})

local function update()
  local date = os.date("%a. %d %b.")
  local time = os.date("%H:%M")
  cal:set({ icon = date, label = time })
end

cal:subscribe("routine", update)
cal:subscribe("forced", update)
