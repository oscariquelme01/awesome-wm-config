-- local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- local rounded_shape = require("utilities.utils").rounded_shape()

return function(s)
    -- local popup = awful.popup {
    --     ontop = true,
    --     screen = s,
    --     visible = false,
    --     shape = rounded_shape(2),
    --     offset = { y = 5 },
    --     border_width = 1,
    -- }

    local information_widget = wibox.widget{
        markup = '<span foreground="' .. beautiful.light_white .. '"></span>',
        font = beautiful.font_extra_large,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    -- function information.toggle()

    return information_widget
end

