local beautiful = require("beautiful")
local awful = require("awful")

return function()

    local date_format = '<span font="' .. beautiful.font .. '" foreground="' .. beautiful.yellow .. '">%a %b %d</span>'
    local time_format = '<span font="' .. beautiful.font .. '" foreground="' .. beautiful.red .. '">%H:%M</span>'

    local clock = awful.widget.textclock(date_format ..' , '.. time_format, 5
    )

    return clock

end
