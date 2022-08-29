local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- require status bar widgets
local battery_widget = require("modules.control_pannel.status_line.battery")
local date_widget = require("modules.control_pannel.status_line.date")
local toggle_info_widget = require("modules.control_pannel.status_line.toggle_info")

return function (action)
    local  battery = battery_widget()
    local date = date_widget()
    local toggle_info = toggle_info_widget(action)

    return wibox.widget{
        battery,
        {
            toggle_info,
            widget = wibox.container.margin,
            top = dpi(8),
            bottom = dpi(8),
            left = dpi(130),
            right = dpi(130)
        },
        date,
        layout = wibox.layout.align.horizontal,
        widget = wibox.container.background,
        bg = beautiful.deeper_black,
        forced_height = dpi(35),
    }
end
