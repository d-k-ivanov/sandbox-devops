--{{---| Main spacer  |-----------------------------------------------------------------------------------------------------
spacer0 = wibox.widget.textbox()
spacer0:set_text(' ')

spacer1 = wibox.widget.textbox()
spacer1:set_text('>')

spacer2 = wibox.widget.textbox()
spacer2:set_text('<')

spacer = wibox.widget.textbox()
spacer:set_text(' | ')

--{{---| Battery  |---------------------------------------------------------------------------------------------------------
  -- Battery attributes
local bat_state  = ""
local bat_charge = 0
local bat_time   = 0
local blink      = true

  -- Icon
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.battery_full)

  -- Charge %
batpct = wibox.widget.textbox()
vicious.register(batpct, vicious.widgets.bat, function(widget, args)
  bat_state  = args[1]
  bat_charge = args[2]
  bat_time   = args[3]

  if args[1] == "↯" then
    baticon:set_image(beautiful.battery_charging_full)
  elseif args[1] == "-" or args[1] == "⌁" then
    if bat_charge > 93 then
      baticon:set_image(beautiful.battery_5)
    elseif bat_charge <= 93 and bat_charge > 77 then
      baticon:set_image(beautiful.battery_4)
    elseif bat_charge <= 77 and bat_charge > 49 then
      baticon:set_image(beautiful.battery_3)
    elseif bat_charge <= 49 and bat_charge > 28 then
      baticon:set_image(beautiful.battery_2)
    elseif bat_charge <= 28 and bat_charge > 7 then
      baticon:set_image(beautiful.battery_1)
    elseif bat_charge <= 7 then
      baticon:set_image(beautiful.battery_empty)
    end
  elseif args[1] == "+" then
    if bat_charge > 93 then
      baticon:set_image(beautiful.battery_charging_5)
    elseif bat_charge <= 93 and bat_charge > 77 then
      baticon:set_image(beautiful.battery_charging_4)
    elseif bat_charge <= 77 and bat_charge > 49 then
      baticon:set_image(beautiful.battery_charging_3)
    elseif bat_charge <= 49 and bat_charge > 28 then
      baticon:set_image(beautiful.battery_charging_2)
    elseif bat_charge <= 28 and bat_charge > 7 then
      baticon:set_image(beautiful.battery_charging_1)
    elseif bat_charge <= 7 then
      baticon:set_image(beautiful.battery_charging_empty)
    end
  else
    baticon:set_image(beautiful.battery_missing)
  end

  return args[2] .. "%"
end, nil, "BAT0")

  -- Buttons
function popup_bat()
  local state = ""
  if bat_state == "↯" then
    state = "Full"
  elseif bat_state == "↯" then
    state = "Charged"
  elseif bat_state == "+" then
    state = "Charging"
  elseif bat_state == "-" then
    state = "Discharging"
  elseif bat_state == "⌁" then
    state = "Not charging"
  else
    state = "Unknown"
  end

  naughty.notify { text = "Charge : " .. bat_charge .. "%\nState  : " .. state ..
    " (" .. bat_time .. ")", timeout = 5, hover_timeout = 0.5 }
end

do
local started=false
  batpct:buttons(awful.util.table.join(
    awful.button({ }, 1, popup_bat),
    --awful.button({ }, 1, function () naughty.notify { text = bat_state , timeout = 5, hover_timeout = 0.5 } end),
    --awful.button({ }, 3, power_menu)
    awful.button({ }, 3, function()
      if started then
        awful.util.spawn("pkill -f 'gnome-control-center power'")
      else
        awful.util.spawn("gnome-control-center power")
      end
      started=not started
    end)
  ))
end

baticon:buttons(batpct:buttons())

batt = wibox.widget.textbox()
vicious.register(batt, vicious.widgets.bat, "Batt: $2% Rem: $3", 61, "BAT0")

--{{---| Network usage  |---------------------------------------------------------------------------------------------------
  -- Initialize widget, use widget({ type = "textbox" }) for awesome < 3.5
lan_usage       = wibox.widget.textbox()
  -- Register widget
vicious.register(lan_usage, vicious.widgets.net, '<span color="#CC9393">${enp6s0 down_kb}</span> <span color="#7F9F7F">${enp6s0 up_kb}</span>', 3)

wifi_usage      = wibox.widget.textbox()
  -- Register widget
vicious.register(wifi_usage, vicious.widgets.net, '<span color="#CC9393">${wlp3s0 down_kb}</span> <span color="#7F9F7F">${wlp2s0 up_kb}</span>', 3)

--{{---| Volume  |----------------------------------------------------------------------------------------------------------
  -- Cache
vicious.cache(vicious.widgets.volume)
  -- Icon
volicon = wibox.widget.imagebox()
  -- Volume %
volpct = wibox.widget.textbox()
vicious.register(volpct, vicious.widgets.volume, function(widget, args)
  vol_level = args[1]
  vol_state = args[2]

  if args[2] == "♩" then
    volicon:set_image(beautiful.volume_muted)
  else
    if vol_level > 75 then
      volicon:set_image(beautiful.volume_high)
    elseif vol_level <= 75 and vol_level > 45 then
      volicon:set_image(beautiful.volume_medium)
    elseif vol_level <= 45 and vol_level > 20 then
      volicon:set_image(beautiful.volume_low)
    elseif vol_level <= 20 then
      volicon:set_image(beautiful.volume_off)
    end
   end

  return args[1] .. "%"
end, nil, "Master")

  -- Buttons
do
  local started=false
  volicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function() awful.spawn.with_shell("amixer -q set Master toggle", false)      end),
    awful.button({ }, 2, function() awful.spawn("amixer sset Mic toggle", false)           end),
    awful.button({ }, 3, function()
      if started then
        awful.spawn("pkill -f 'pavucontrol'", false)
      else
        awful.spawn("pavucontrol", false)
      end
      started=not started
    end),
    awful.button({ }, 4, function() awful.spawn.with_shell("amixer -q set Master 1%+ unmute", false)  end),
    awful.button({ }, 5, function() awful.spawn.with_shell("amixer -q set Master 1%- unmute", false)  end)
  ))
end

volpct:buttons(volicon:buttons())

--{{---| Keyboard layout - widget|------------------------------------------------------------------------------------------
kbdcfg            = {}
kbdcfg.cmd        = "setxkbmap"
--kbdcfg.layout     = { { "us", "" , "US" }, { "ru", "" , "RU" }, { "es", "" , "ES" } }
kbdcfg.layout     = { { "us", "" , "US" }, { "ru", "" , "RU" } }
kbdcfg.current    = 1  -- us is our default layout
-- widget for TEXT
--kbdcfg.widget     = wibox.widget.textbox()
--kbdcfg.widget:set_text(" " .. kbdcfg.layout[kbdcfg.current][3] .. " ")
--kbdcfg.switch     = function ()
--   kbdcfg.current  = kbdcfg.current % #(kbdcfg.layout) + 1
--   local t = kbdcfg.layout[kbdcfg.current]
--   kbdcfg.widget:set_text(" " .. t[3] .. " ")
--   os.execute( kbdcfg.cmd .. " " .. t[1] .. ",us " .. t[2] )
-- end
-- Widget for FLAG
kbdcfg.widget     = wibox.widget.imagebox()
kbdcfg.widget:set_image(awful.util.getdir("config") .. "/theme/icons/flags/us.png")

kbdcfg.switch     = function ()
  kbdcfg.current  = kbdcfg.current % #(kbdcfg.layout) + 1
  local t = kbdcfg.layout[kbdcfg.current]
  kbdcfg.widget:set_image(awful.util.getdir("config") .. "/theme/icons/flags/" .. kbdcfg.layout[kbdcfg.current][1] .. ".png")
  os.execute( kbdcfg.cmd .. " " .. t[1] .. ",us " .. t[2] )
end

--{{---| Keyboard layout - mouse |------------------------------------------------------------------------------------------
kbdcfg.widget:buttons(
 awful.util.table.join(awful.button({ }, 1, function () kbdcfg.switch() end))
)


--{{---| Clock  |-----------------------------------------------------------------------------------------------------------
--mytextclock = wibox.widget.textclock("%H:%M")
mytextclock = wibox.widget.textclock()
mytextclock:connect_signal("button::press", function(_,_,_,button)
  if     (button == 1) then
    awful.spawn.easy_async("cal -1", function(stdout, stderr, reason, exit_code)
      naughty.notify { text = stdout, timeout = 5, hover_timeout = 0.5  }
    end)
  elseif (button == 3) then
    awful.spawn.easy_async("cal -3", function(stdout, stderr, reason, exit_code)
      naughty.notify { text = stdout, timeout = 5, hover_timeout = 0.5  }
    end)
  end
end)
--lain.widget.calendar({ attach_to = { mytextclock }})

--{{---| System Settings |--------------------------------------------------------------------------------------------------

setIcon = wibox.widget.imagebox()
setIcon:set_image(beautiful.system_monitor_icon)
  -- Buttons
do
  local started_1=false
  setIcon:buttons(awful.util.table.join(
     awful.button({ }, 1, function()
      if started_1 then
        awful.util.spawn("pkill -f 'gnome-system-monitor'")
      else
        awful.util.spawn("gnome-system-monitor")
      end
      started_1=not started_1
    end),
     awful.button({ }, 3, function()
      if started_3 then
        awful.util.spawn("pkill -f 'gnome-control-center'")
      else
        awful.util.spawn("gnome-control-center")
      end
      started_3=not started_3
    end)
  ))
end


