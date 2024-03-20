--{{---| Backlight |-------------------------------------------------------------------------------------------------------
local awful   = require("awful")
local wibox   = require("wibox")
local gears   = require("gears")
local naughty = require("naughty")
local string  = require("string")
local watch   = require("awful.widget.watch")
local spawn   = require("awful.spawn")

local function script_path()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match("(.*/)"):gsub([[//]],[[/]])
end

local widget_dir                  = script_path()

-- Commands
local brightness_bin_init         = "echo 100 > /sys/class/backlight/acpi_video0/brightness"
local brightness_bin_set          = "xbacklight -set "
local brightness_bin_get          = "xbacklight -get"
local brightness_inc_level_to_10  = "xbacklight -inc 10"
local brightness_dec_level_to_10  = "xbacklight -dec 10"

-- Images
local backlight_high              = widget_dir .. "display-brightness-high.svg"
local backlight_medium            = widget_dir .. "display-brightness-medium.svg"
local backlight_low               = widget_dir .. "display-brightness-low.svg"
local backlight_off               = widget_dir .. "display-brightness-off.svg"

-- Boxes
local brightness_text = wibox.widget.textbox(" n/a")
local brightness_icon = wibox.widget {
  {
    id = "icon",
    image = backlight_high,
    widget = wibox.widget.imagebox,
  },
  layout = wibox.container.margin(_, _, _, 3),
  set_image = function(self, path)
    self.icon.image = path
  end
}

brightness_widget = wibox.widget {
  brightness_icon,
  brightness_text,
  layout = wibox.layout.fixed.horizontal,
}

local function update_text(widget, stdout, stderr, exitreason, exitcode)
  -- for acpilight
  --local brightness_level = tonumber(stdout)
  -- for xbacklight
  local brightness_level = tonumber(string.format("%.0f", stdout))
  widget:set_text(" " .. brightness_level .. "%")
end

local function update_icon(widget, stdout, stderr, exitreason, exitcode)
  -- for acpilight
  --local brightness_level = tonumber(stdout)
  -- for xbacklight
  local brightness_level = tonumber(string.format("%.0f", stdout))
  if (brightness_level > 75) then
      widget.image = backlight_high
    elseif (brightness_level <= 75 and brightness_level > 45) then
      widget.image = backlight_medium
    elseif (brightness_level <= 45 and brightness_level > 20) then
      widget.image = backlight_low
    elseif (brightness_level <= 20) then
      widget.image = backlight_off
    end
end

local function release_brightness()
  awful.spawn.with_shell(brightness_bin_init  , false)
  awful.spawn(brightness_bin_set .. "90"      , false)
  awful.spawn(brightness_bin_set .. "100"     , false)
end

-- Old signal processing
--do
--  brightness_widget:buttons(
--    gears.table.join(
--      awful.button({ }, 1,  function()
--                              awful.spawn(brightness_bin_init,          false)
--                              awful.spawn(brightness_bin_set .. "90",   false)
--                              awful.spawn(brightness_bin_set .. "100",  false)  end),
--      awful.button({ }, 4, function()
--                              awful.spawn(brightness_inc_level_to_10,   false)  end),
--      awful.button({ }, 5, function()
--                              awful.spawn(brightness_dec_level_to_10,   false)  end)
--    )
--  )
--end

brightness_widget:connect_signal("button::press", function(_,_,_,button)
  if     (button == 1) then awful.spawn.with_shell(brightness_bin_init          , false)
                            awful.spawn(brightness_bin_set .. "90"              , false)
                            awful.spawn(brightness_bin_set .. "100"             , false)
  elseif (button == 3) then awful.spawn(brightness_bin_set .. "10"              , false)
  elseif (button == 4) then awful.spawn(brightness_inc_level_to_10              , false)
  elseif (button == 5) then awful.spawn(brightness_dec_level_to_10              , false)
  end

--  spawn.easy_async(brightness_bin_get, function(stdout, stderr, exitreason, exitcode)
  spawn(brightness_bin_get, function(stdout, stderr, exitreason, exitcode)
    update_icon(brightness_widget, stdout, stderr, exitreason, exitcode)
  end)
end)

watch(brightness_bin_get, 2, update_text, brightness_text)
watch(brightness_bin_get, 3, update_icon, brightness_icon)
