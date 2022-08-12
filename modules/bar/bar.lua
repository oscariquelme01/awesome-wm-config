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
         s.wibar = awful.wibar({position = "left", screen = s, stretch = true})

         s.wibar:setup {
             layout = wibox.layout.align.vertical,
             expand = "none",
             { -- Left widgets
                s.taglist,
                layout = wibox.layout.fixed.vertical,
             },
             { -- Middle widgets
                 layout = wibox.layout.fixed.vertical,
                 wibox.layout.margin(s.clock, 7, 0, 0, 0),
                 -- s.clock
             },
             { -- Right widgets
                layout = wibox.layout.fixed.vertical,
                wibox.layout.margin(s.info, 0, 20, 0, 0)
             }
         }
     end)

