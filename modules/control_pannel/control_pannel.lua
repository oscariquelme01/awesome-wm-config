local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local rubato = require("lib.rubato")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("utilities.utils")

local slider_pannel = require("modules.control_pannel.sliders")
local toggler_pannel = require("modules.control_pannel.togglers")
local profile_pannel = require("modules.control_pannel.profile_pannel")
local status_pannel = require("modules.control_pannel.status_line")

awful.screen.connect_for_each_screen(function(s)

    -- pannels's height value when the extra pannel is on/off
    local extended_height = dpi(680)
    local shrinked_height = dpi(460)
    -- pannel's y position when the extra pannel is on/off
    local extended_pos = dpi(320)
    local shrinked_pos = dpi(540)

    -- Main pannel
    local control_pannel = wibox({
        type = "dock",
        shape = utils.rounded_rect(dpi(12)),
        screen = s,
        border_width = dpi(2),
        border_color = beautiful.black,
        width = dpi(520),
        height = shrinked_height,
        x = dpi(100),
        bg = beautiful.deep_black,
        ontop = true,
        visible = false,
    })

    -- Initially the extra pannel is hidden
    control_pannel.extra = false

    -- Toggle function to open/close the control pannel
    control_pannel.toggle = function ()
        if s.control_pannel.visible == false then
            -- check if the extra pannel is on
            if s.control_pannel.extra == false then
                control_pannel.slide.target = shrinked_pos
            else
                control_pannel.slide.target = extended_pos
            end
            control_pannel.visible = true
        else
            control_pannel.slide.target = s.geometry.height
            control_pannel.slide_end:again()
        end
    end

    -- Toggle function to open close the extra pannel
    control_pannel.toggle_extra = function()
        if s.control_pannel.extra == false then
            control_pannel.move_extra.target = extended_pos
            control_pannel.slide_extra_end:again()
        else
            -- control_pannel.fake_pannel.visible = true
            control_pannel.slide_extra.target = shrinked_height
            control_pannel.slide_extra_end:again()
        end
    end

    -- now this is some real cool engineering stuff
    -- If you only animate the control pannel height and y position the fixed layout will put the status pannel all over the place
    -- The solution here is to create a fake empty bakground widget and animate its height at the very same time as the control pannel height, and whenever its over switch this widget for the actual extra pannel
    -- This way, the status line stays at the bottom without disappearing
    control_pannel.fake_pannel = wibox.widget{
        wibox.widget.base.make_widget(),
        widget = wibox.container.background,
        bg = beautiful.deep_black,
        shape = utils.rounded_rect(dpi(2)),
        -- visible = false,
        forced_height = dpi(220)
    }

    -- Sub pannels
    local sliders = slider_pannel()
    local togglers = toggler_pannel()
    local profile = profile_pannel()
    local status_line = status_pannel(control_pannel.toggle_extra)

    -- keep a reference to the layout to be able to swap widgets
    control_pannel.layout = wibox.widget {
        layout = wibox.layout.fixed.vertical
    }

    -- Initial setup
    control_pannel:setup {
        profile,
    {
            sliders,
            widget = wibox.container.margin,
            margins = dpi(6),
        },
    {
            togglers,
            widget = wibox.container.margin,
            margins = dpi(6),
        },
        control_pannel.fake_pannel,
    {
            status_line,
            widget = wibox.container.margin,
            margins = dpi(10),
        },
        layout = control_pannel.layout,
    }

    -- Keep a reference through the screen so that it can be access later
    s.control_pannel = control_pannel


    ----------------
    -- animations --
    ----------------
    control_pannel.slide = rubato.timed{
        pos = s.geometry.height,
        rate = 60,
        intro = 0.14,
        duration = 0.33,
        subscribed = function(pos) s.control_pannel.y = s.geometry.y + pos end
    }

    -- timer to be executed when the slide out animation is over
    control_pannel.slide_end = gears.timer({
        single_shot = true,
        timeout = 0.33 + 0.08,
        callback = function()
            s.control_pannel.visible = false
        end,
    })



    -- extra animations
    control_pannel.slide_extra = rubato.timed{
        pos = dpi(500),
        rate = 60,
        intro = 0.14,
        duration = 0.33,
        subscribed = function(pos)
            control_pannel.height = pos
            control_pannel.fake_pannel.forced_height = pos - shrinked_height
        end
    }

    control_pannel.move_extra = rubato.timed{
        pos = dpi(500),
        rate = 60,
        intro = 0.14,
        duration = 0.33,
        subscribed = function(pos)
            s.control_pannel.y = pos
        end
    }

    -- timer to be executed when the slide extra animation is over
    -- in case the extra pannel is on, it will set the slide_extra.target to shrink it
    -- in case it is not, it will set the move_extra.target up to make space for the extra pannel
    control_pannel.slide_extra_end = gears.timer({
        single_shot = true,
        timeout = 0.33 + 0.08,
        callback = function()
            if control_pannel.extra == true then
                -- fake_pannel.visible = false
                control_pannel.move_extra.target = shrinked_pos
                control_pannel.extra = false
            else
                control_pannel.slide_extra.target = extended_height
                -- control_pannel.fake_pannel.visible = true
                control_pannel.extra = true
            end
        end,
    })

end)

