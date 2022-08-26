local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local rubato = require("lib.rubato")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

local profile = require("modules.control_pannel.profile_pannel")
local volume_slider = require("modules.control_pannel.sliders.volume")
local slider_pannel = require("modules.control_pannel.sliders")

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
    })

    -- Sub pannels
    local profile_pannel = profile()
    local vol_slider = volume_slider()
    local sliders = slider_pannel()

    -- Keep a reference through the screen so that it can be access later
    s.control_pannel = control_pannel

    -- Initial setup
    control_pannel:setup {
        {
        --     {
        --         {
        --             {
        --                 vol_slider,
        --                 layout = wibox.layout.align.vertical,
        --             },
        --             widget = wibox.container.margin,
        --             margins = dpi(20),
        --         },
        --         widget = wibox.container.background,
        --         bg = beautiful.black,
        --         shape = utils.rounded_rect(dpi(10)),
        --         -- forced_height = dpi(100),
        --     },
            sliders,
            widget = wibox.container.margin,
            margins = dpi(6),
        },
        layout = wibox.layout.align.vertical,
    }

    -- animations
    local slide = rubato.timed{
        pos = s.geometry.height,
        rate = 60,
        intro = 0.14,
        duration = 0.33,
        subscribed = function(pos) s.control_pannel.y = s.geometry.y + pos end
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
