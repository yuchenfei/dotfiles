local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local keyboard_map = {
  ["com.apple.keylayout.ABC"] = "EN",
  ["com.apple.inputmethod.SCIM.ITABC"] = "中",
  ["com.apple.inputmethod.SCIM.Shuangpin"] = "双",
  ["im.rime.inputmethod.Squirrel.Hans"] = "中",
  ["im.rime.inputmethod.Squirrel.Hant"] = "繁",
}

local keyboard = Sbar.add("item", "keyboard", {
  position = "right",
  icon = {
    string = icons.keyboard,
    color = colors.white,
    font = { family = settings.font.text },
    width = 30,
    align = "center",
  },
  label = {
    font = {
      family = settings.font.text,
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
Sbar.add("event", "rime_mode_changed")

keyboard:subscribe({ "keyboard_change", "rime_mode_changed", "forced" }, function()
  Sbar.exec(
    [[source=$(im-select) || exit
printf '%s\n' "$source"
cat "$HOME/Library/Caches/sketchybar-rime-mode" 2>/dev/null || true]],
    function(result, exit_code)
      if exit_code ~= 0 then
        keyboard:set({
          icon = { color = colors.white },
          label = { string = "??" },
        })
        return
      end
      local input_method = result:match("^(%S+)")
      local label = keyboard_map[input_method] or "??"
      local icon_color = colors.white
      if input_method and input_method:match("^im%.rime%.inputmethod%.Squirrel") then
        icon_color = colors.blue
        local mode = result:match("\n%s*(%S+)%s*$")
        if mode == "EN" or mode == "中" then
          label = mode
        end
      end
      keyboard:set({
        icon = { color = icon_color },
        label = { string = label },
      })
    end
  )
end)
