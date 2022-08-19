local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local rubato = require("lib.rubato")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

awful.screen.connect_for_each_screen(function(s)

    -- Main pannel
    local control_pannel = wibox({
        type = "dock",
        shape = utils.rounded_rect(dpi(12)),
        screen = s,
        border_width = dpi(2),
        border_color = beautiful.dark_grey,
        width = dpi(620),
        height = dpi(720),
        x = dpi(100),
        bg = beautiful.deep_black,
        ontop = true,
        visible = false,
        markup = 'Holaaa',
        widget = wibox.widget.textbox,
    })

    -- Keep a reference through the screen so that it can be access later
    s.control_pannel = control_pannel

    -- Initial setup
    control_pannel:setup { -- Main container
        { -- Margin container for volume and brightness pannel
            { -- Volume and brightness slider container
                wibox.widget.base.make_widget(),
                widget = wibox.container.background,
                bg = beautiful.black,
                shape = utils.rounded_rect(dpi(10)),
                forced_height = dpi(100)
            },
            widget = wibox.container.margin,
            left = dpi(6),
            right = dpi(6),
            top = dpi(8),
            bottom = dpi(8),
            },
        layout = wibox.layout.fixed.vertical,
    }

    -- animations
    local slide = rubato.timed{
        pos = s.geometry.height,
        rate = 60,
        intro = 0.14,
        duration = 0.33,
        subscribed = function(pos) s.control_pannel.y = s.geometry.y + pos utils.log((s.geometry.y + pos) .. "\n") end
    }

    -- timer to be executed when the slide out animation is over
    local slide_end = gears.timer({
        single_shot = true,
        timeout = 0.33 + 0.08,
        callback = function()
            s.control_pannel.visible = false
        end,
    })

    -- Toggle function to open/close the function
    -- TODO: fix the double click open bug
    control_pannel.toggle = function ()
        if s.control_pannel.visible == false then
            slide.target = dpi(320)
            control_pannel.visible = true
        else
            slide.target = s.geometry.height
            slide_end:again()
        end
    end


end)
 
