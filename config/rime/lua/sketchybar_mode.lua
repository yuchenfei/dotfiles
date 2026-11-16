local M = {}
local cache_path = os.getenv("HOME") .. "/Library/Caches/sketchybar-rime-mode"

local function publish(context)
  local mode = context:get_option("ascii_mode") and "EN" or "中"
  local cache = io.open(cache_path, "r")
  if cache then
    local previous = cache:read("*l")
    cache:close()
    if previous == mode then
      return
    end
  end

  local file = io.open(cache_path .. ".tmp", "w")
  if not file then
    return
  end
  file:write(mode, "\n")
  file:close()
  if not os.rename(cache_path .. ".tmp", cache_path) then
    return
  end

  -- Squirrel does not inherit the shell's Nix PATH.
  os.execute(
    '"/etc/profiles/per-user/' .. os.getenv("USER") .. '/bin/sketchybar" --trigger rime_mode_changed >/dev/null 2>&1 &'
  )
end

function M.init(env)
  local context = env.engine.context
  env.sketchybar_connection = context.option_update_notifier:connect(function(ctx, option)
    if option == "ascii_mode" then
      publish(ctx)
    end
  end)
  publish(context)
end

function M.func(_, env)
  -- Also refresh when typing in a different Rime session/application.
  publish(env.engine.context)
  return 2 -- kNoop: leave all key handling to the existing processors.
end

function M.fini(env)
  if env.sketchybar_connection then
    env.sketchybar_connection:disconnect()
  end
end

return M
