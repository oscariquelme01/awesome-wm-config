local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

local blue_light_toggler = require("modules.control_pannel.togglers.blue_light")

return function ()
    local blue_light = blue_light_toggler()

    return wibox.widget{
                {
                    {
                        {
                            blue_light,
                            layout = wibox.layout.fixed.horizontal,
                            spacing = dpi(40)
                        },
                        widget = wibox.container.margin,
                        right = dpi(20),
                        left = dpi(20),
                    },
                    widget = wibox.container.background,
                    bg = beautiful.deeper_black,
                    shape = utils.rounded_rect(dpi(10)),
                },
                widget = wibox.container.margin,
                margins = dpi(6),
    }
end
