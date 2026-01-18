local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local keyboard_map = {
  ["com.apple.keylayout.ABC"] = "EN",
  ["com.tencent.inputmethod.wetype.pinyin"] = "中",
}

local keyboard = Sbar.add("item", "keyboard", {
  position = "right",
  icon = { string = icons.keyboard },
  label = {
    font = {
      family = settings.font.numers,
    },
    string = "??",
    width = 25,
    align = "center",
  },
})

Sbar.add("bracket", "keyboard.bracket", { keyboard.name }, {
  background = { color = colors.transparent, border_color = colors.grey },
})

Sbar.add("item", "keyboard.space", {
  position = "right",
  width = settings.space,
})

Sbar.add("event", "keyboard_change", "AppleSelectedInputSourcesChangedNotification")

keyboard:subscribe({ "keyboard_change", "forced" }, function()
  Sbar.exec("im-select", function(input_method)
    input_method = input_method:gsub("\n", "")
    keyboard:set({
      label = { string = keyboard_map[input_method] },
    })
  end)
end)
