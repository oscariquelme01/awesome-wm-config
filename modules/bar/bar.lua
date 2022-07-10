 local wibox = require("wibox")
 local awful = require("awful")

 local taglist = require("modules.bar.taglist")


 awful.screen.connect_for_each_screen(
     function(s)
         s.taglist = taglist(s)


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
                layout = wibox.layout.fixed.horizontal,
             }
         }
     end)

