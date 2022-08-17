local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local icons = require("icons")

return function()

    local launcher = wibox.widget {
        widget = wibox.widget.imagebox,
        image = icons.rocket,
        forced_width = dpi(30),
        forced_height = dpi(30),
        resize = true,
        valign = "center",
        align = "center"
    }

    return launcher

end
