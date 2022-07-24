 local wibox = require("wibox")
 local awful = require("awful")

 local taglist = require("modules.bar.taglist")
 local clock = require("modules.bar.clock")


 awful.screen.connect_for_each_screen(
     function(s)
         s.taglist = taglist(s)
         s.clock = clock()


         -- wibar
         s.wibar = awful.wibar({position = "top", screen = s, stretch = true})

         s.wibar:setup {
             layout = wibox.layout.align.horizontal,
             { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
             },
             {
                 s.taglist, -- Middle widgets
                 layout = wibox.layout.fixed.horizontal,
                 expand = "none"
             },
             { -- Right widgets
                wibox.layout.margin(s.clock, 10, 10, 10, 10),
                layout = wibox.layout.fixed.horizontal,
             }
         }
     end)

