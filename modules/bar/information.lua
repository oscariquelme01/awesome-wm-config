local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local cpu_widget = require("modules.widgets.cpu")
local ram_widget = require("modules.widgets.ram")

local dpi = beautiful.xresources.apply_dpi

return function(s)

    local cpu = cpu_widget()
    local ram = ram_widget()

    -- popup with all the info
    local popup = awful.popup {
        ontop = true,
        screen = s,
        visible = false,
        offset = { y = 40, x = 20 },
        border_width = 1,
        width = dpi(40),
        height = dpi(20),
        shape = gears.shape.rounded_rect,
        fg = beautiful.text,
        bg = beautiful.black,

		widget = {
			{
				{
					layout = wibox.layout.align.vertical,
                    expand = "none",

                    wibox.widget{ markup = '<span foreground="' .. beautiful.red .. '"> Hardware: </span>',
                    align  = 'center', valign = 'center',
                    widget = wibox.widget.textbox },

                    cpu,
                    ram,
				},
                margins = dpi(16),
				widget = wibox.container.margin,
			},
			bg = beautiful.wibar_bg,
			widget = wibox.container.background,
		},
    }

    local information_widget = wibox.widget{
        markup = '<span foreground="' .. beautiful.light_white .. '"></span>',
        font = beautiful.font_extra_large,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }

    -- toggle function necessary for keybind and button press
    function information_widget.toggle()

        if popup.visible then
            popup.visible = not popup.visible
        else
            -- popup placement
            awful.placement.top_right(popup, { margins = { top = beautiful.wibar_height + 10, right = 10 }, parent = awful.screen.focused() })

            popup.visible = true

        end
    end

    -- toggle widget on click
    information_widget:connect_signal("button::press",
        function (_, _, _, button)
            if button == 1 then information_widget.toggle() end
        end
    )

    return information_widget
end

