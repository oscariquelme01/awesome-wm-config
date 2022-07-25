 local wibox = require("wibox")
 local awful = require("awful")

 local taglist = require("modules.bar.taglist")
 local clock = require("modules.bar.clock")
 local info = require("modules.bar.information")


 awful.screen.connect_for_each_screen(
     function(s)
         s.taglist = taglist(s)
         s.clock = clock()
         s.info = info(s)

         -- wibar
         s.wibar = awful.wibar({position = "top", screen = s, stretch = true})

         s.wibar:setup {
             layout = wibox.layout.align.horizontal,
             expand = "none",
             { -- Left widgets
                s.taglist,
                layout = wibox.layout.fixed.horizontal,
             },
             { -- Middle widgets
                 layout = wibox.layout.fixed.horizontal,
                 wibox.layout.margin(s.clock, 10, 10, 10, 10),
             },
             { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                wibox.layout.margin(s.info, 0, 20, 0, 0)
             }
         }
     end)

