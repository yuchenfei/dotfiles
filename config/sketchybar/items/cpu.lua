local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
Sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = Sbar.add("graph", "cpu", 42, {
  position = "right",
  padding_right = settings.paddings.item + 6,
  icon = { string = icons.cpu },
  label = {
    padding_right = 0,
    y_offset = 4,
    font = {
      family = settings.font.numbers,
      style = "Bold",
      size = 9.0,
    },
    string = "cpu ??%",
    width = 0,
    align = "right",
  },
  background = {
    drawing = true,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    height = 22,
  },
  graph = { color = colors.blue },
})

cpu:subscribe("cpu_update", function(env)
  -- Also available: env.user_load, env.sys_load
  local load = tonumber(env.total_load)
  cpu:push({ load / 100. })

  local color = colors.blue
  if load > 30 then
    if load < 60 then
      color = colors.yellow
    elseif load < 80 then
      color = colors.orange
    else
      color = colors.red
    end
  end

  cpu:set({
    graph = { color = color },
    label = "cpu " .. env.total_load .. "%",
  })
end)

cpu:subscribe("mouse.clicked", function(_)
  Sbar.exec("open -a 'Activity Monitor'")
end)

Sbar.add("bracket", "cpu.bracket", { cpu.name }, {
  background = { color = colors.transparent, border_color = colors.grey },
})

Sbar.add("item", "cpu.space", {
  position = "right",
  width = settings.space,
})
