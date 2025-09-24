local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local show_normal = settings.battery.style == "Normal"
local show_aldente = settings.battery.style == "AlDente"
local show_percentage = settings.battery.show_percentage

Sbar.add("item", {
  position = "right",
  width = 5,
  icon = { drawing = false },
  label = { drawing = false },
})

local battery = Sbar.add("item", "battery", {
  position = "right",
  padding_left = show_aldente and 0 or settings.paddings.item,
  icon = {
    drawing = show_normal,
    font = {
      style = "Regular",
      size = 18.0,
    },
  },
  label = {
    drawing = show_percentage,
    padding_left = show_aldente and 0 or settings.paddings.label,
    font = { family = settings.font.numbers },
  },
  update_freq = 120,
})

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
  Sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local color = colors.green
    local label = "?"

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      local lead = ""
      if charge < 10 then
        lead = "0"
      end
      label = lead .. charge .. "%"
    end

    if show_normal then
      local charging, _, _ = batt_info:find("AC Power")

      if charging then
        icon = icons.battery.charging
      else
        if found and charge > 80 then
          icon = icons.battery._100
        elseif found and charge > 60 then
          icon = icons.battery._75
        elseif found and charge > 40 then
          icon = icons.battery._50
        elseif found and charge > 20 then
          icon = icons.battery._25
          color = colors.orange
        else
          icon = icons.battery._0
          color = colors.red
        end
      end
    end

    battery:set({
      icon = {
        string = icon,
        color = color,
      },
      label = { string = label },
    })
  end)
end)

local aldente = nil

if show_aldente then
  aldente = Sbar.add("alias", "AlDente", {
    position = "right",
    alias = {
      color = colors.white,
      scale = 1.0,
      update_freq = 1,
    },
    background = {
      padding_left = 0,
      padding_right = -5,
    },
  })
end

Sbar.add("bracket", {
  battery.name,
  aldente and aldente.name or nil,
}, {
  background = {
    color = colors.transparent,
    border_color = colors.grey,
  },
})
