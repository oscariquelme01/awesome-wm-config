 local wibox = require("wibox")
 local awful = require("awful")

 local taglist = require("modules.bar.taglist")
 local clock = require("modules.bar.clock")
 local battery = require("modules.bar.battery")
 local beautiful = require("beautiful")
 local dpi = beautiful.xresources.apply_dpi


 awful.screen.connect_for_each_screen(
     function(s)
         s.taglist = taglist(s)
         s.clock = clock()
         s.battery = battery()

         -- wibar
         s.wibar = awful.wibar({position = "left", screen = s, stretch = true})

         s.wibar:setup {
             { -- Left widgets
                layout = wibox.layout.fixed.vertical,
             },
             { -- Middle widgets
                s.taglist,
                -- margins = {left = dpi(4), right = dpi(4)},
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

