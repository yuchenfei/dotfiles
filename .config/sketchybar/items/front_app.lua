local front_app = Sbar.add("item", {
  icon = {
    drawing = false,
  },
  label = {
    font = {
      style = "Black",
      size = 12.0,
    },
  },
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    label = {
      string = env.INFO,
    },
  })

  -- Or equivalently:
  -- Sbar.set(env.NAME, {
  --   label = {
  --     string = env.INFO
  --   }
  -- })
end)
