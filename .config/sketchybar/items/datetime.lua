local colors = require("colors")
local settings = require("settings")

local open_calendar = "open -a Calendar.app"

local date = Sbar.add("item", "date", {
  position = "right",
  y_offset = 5,
  width = 0,
  icon = {
    drawing = "off",
  },
  label = {
    font = {
      style = "Semibold",
      size = 7,
    },
  },
  click_script = open_calendar,
  update_freq = 60,
})

date:subscribe({ "forced", "routine", "system_woke" }, function(_)
  date:set({ label = os.date("%a, %b %d") })
end)

local clock = Sbar.add("item", "clock", {
  position = "right",
  y_offset = -4,
  icon = {
    drawing = "off",
  },
  label = {
    font = { family = settings.font.numbers, style = "Bold", size = 9 },
  },
  click_script = open_calendar,
  update_freq = 10,
})

clock:subscribe({ "forced", "routine", "system_woke" }, function(_)
  clock:set({ label = os.date("%I:%M %p") })
end)

Sbar.add("bracket", { date.name, clock.name }, {
  background = {
    color = colors.transparent,
    border_color = colors.grey,
  },
})
