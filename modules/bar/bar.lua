 local wibox = require("wibox")
 local awful = require("awful")
 local beautiful = require("beautiful")
 local dpi = beautiful.xresources.apply_dpi

 local taglist = require("modules.bar.taglist")
 local clock = require("modules.bar.clock")
 local launcher = require("modules.bar.launcher")
 local battery = require("modules.bar.battery")


 awful.screen.connect_for_each_screen(
     function(s)
         s.taglist = taglist(s)
         s.clock = clock()
         s.battery = battery()
         s.launcher = launcher()

         -- wibar
         s.wibar = awful.wibar({position = "left", screen = s, stretch = true})

         s.wibar:setup {
             { -- Left widgets
                s.launcher,
                top = dpi(8),
                left = dpi(6),
                right = dpi(6),
                layout = wibox.layout.margin,
             },
             { -- Middle widgets
                s.taglist,
                widget = wibox.container.margin
             },
             { -- Right widgets
                {
                    s.battery,
                    left = dpi(4),
                    right = dpi(4),
                    layout = wibox.container.margin
                 },
                {
                    s.clock,
                    left = dpi(8),
                    layout = wibox.container.margin
                 },
                 layout = wibox.layout.fixed.vertical,
                 spacing = dpi(10)
             },
             layout = wibox.layout.align.vertical,
             expand = "none",
         }
     end)

