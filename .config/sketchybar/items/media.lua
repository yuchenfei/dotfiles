local icons = require("icons")
local colors = require("colors")

local whitelist = { ["com.apple.Music"] = true }

Sbar.exec("pkill -f media_stream.sh >/dev/null; $CONFIG_DIR/helpers/media_stream.sh")

local media_cover = Sbar.add("item", "media.cover", {
  drawing = false,
  position = "right",
  icon = { drawing = false },
  label = { drawing = false },
  background = {
    color = colors.transparent,
    image = {
      scale = 0.4,
      corner_radius = 8,
    },
  },
  popup = {
    horizontal = true,
    align = "center",
  },
  updates = true,
})

local media_artist = Sbar.add("item", "media.artist", {
  drawing = false,
  position = "right",
  padding_right = 0,
  width = 0,
  scroll_texts = true,
  icon = { drawing = false },
  label = {
    color = { alpha = 0.6 }, -- colors.with_alpha(colors.white, 0.6),
    y_offset = 6,
    font = { size = 9 },
    max_chars = 18,
    width = 0,
  },
})

local media_title = Sbar.add("item", "media.title", {
  drawing = false,
  position = "right",
  padding_right = 0,
  scroll_texts = true,
  icon = { drawing = false },
  label = {
    y_offset = -5,
    font = { size = 11 },
    max_chars = 16,
    width = 0,
  },
})

Sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.back },
  label = { drawing = false },
  click_script = "media-control previous-track",
})
Sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.play_pause },
  label = { drawing = false },
  click_script = "media-control toggle-play-pause",
})
Sbar.add("item", {
  position = "popup." .. media_cover.name,
  icon = { string = icons.media.forward },
  label = { drawing = false },
  click_script = "media-control next-track",
})

local is_playing = false
local interrupt = 0
local function animate_detail(detail)
  if not is_playing then
    if not detail then
      interrupt = math.max(interrupt - 1, 0)
    end
    if interrupt > 0 and not detail then
      return
    end
  end

  Sbar.animate("tanh", 30, function()
    media_artist:set({ label = { width = detail and "dynamic" or 0 } })
    media_title:set({ label = { width = detail and "dynamic" or 0 } })
  end)
end

local current_app = "None"
media_cover:subscribe("media_stream_changed", function(env)
  current_app = env.identifier
  if current_app == "None" or whitelist[current_app] then
    local drawing = (current_app ~= "None")
    media_artist:set({ drawing = drawing, label = env.artist })
    media_title:set({ drawing = drawing, label = env.title })
    media_cover:set({ drawing = drawing })
  end
end)

media_cover:subscribe("media_state_changed", function(env)
  is_playing = env.playing == "true"
  if whitelist[current_app] then
    animate_detail(is_playing)
  end
end)

media_cover:subscribe("media_cover_changed", function(env)
  if current_app == "None" or whitelist[current_app] then
    local drawing = (current_app ~= "None")
    local cover = env.cover or ""
    media_cover:set({ drawing = drawing, background = { image = { string = cover } } })
  end
end)

media_cover:subscribe("mouse.entered", function()
  if is_playing then
    return
  end
  interrupt = interrupt + 1
  animate_detail(true)
end)

media_cover:subscribe("mouse.exited", function()
  if is_playing then
    return
  end
  Sbar.delay(2, animate_detail)
end)

media_cover:subscribe("mouse.clicked", function()
  media_cover:set({ popup = { drawing = "toggle" } })
end)

media_title:subscribe("mouse.exited.global", function()
  media_cover:set({ popup = { drawing = false } })
end)
