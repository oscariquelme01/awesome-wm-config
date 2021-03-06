pcall(require, "luarocks.loader")

local naughty = require("naughty")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

modkey = "Mod4"
terminal = "alacritty"

-- local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
-- beautiful.init(theme_dir .. "theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

require("modules.bar.bar")
require("modules.binds.bindings")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
        title = "Error occured",
        text = awesome.startup_errors })
end

-- autostart matters (might move to a new module)
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("feh --bg-scale ~/.config/bg/dark-pink-city-5k.png")
awful.spawn.with_shell("xrandr --output HDMI-0 --right-of DP-0")
awful.spawn.with_shell('xmodmap -e "keycode 51 = less greater less greater"')
awful.spawn.with_shell('xmodmap -e "keycode 21 = backslash questiondown exclamdown questiondown dead_tilde asciitilde dead_tilde"')

-- Order in which the different layouts will be switched
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
}

-- load globalkeys from bindings.lua
root.keys(globalkeys)

clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
      c:emit_signal("request::activate", "mouse_click", {raise = true})
      awful.mouse.client.resize(c)
  end)
)

awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
                }
    }
}
