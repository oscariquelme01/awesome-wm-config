----------------------------------------------
-- Credits to the author of the cpu widget found in the following repository as most of the code is taken from there
-- More details can be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/cpu-widget
----------------------------------------------

-- local awful = require("awful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- local gears = require("gears")

-- local CMD = [[sh -c "grep '^cpu.' /proc/stat; ps -eo '%p|%c|%C|' -o "%mem" -o '|%a' --sort=-%cpu ]]
--     .. [[| head -11 | tail -n +2"]]


return function ()

    -- A smaller command, less resource intensive
    local CMD_slim = [[grep --max-count=1 '^cpu.' /proc/stat]]

    local background_color = beautiful.black

    local cpugraph_widget = wibox.widget {
        max_value = 100,
        background_color = background_color,
        forced_width = 20,
        step_width = 2,
        step_spacing = 1,
        widget = wibox.widget.graph,
        color = "linear:0,0:0,20:0," .. beautiful.red .. ":0.3," .. beautiful.yellow .. ":0.6," .. beautiful.green
    }

    -- This part runs constantly
    -- It updates the graph widget in the bar.
    local maincpu = {}
    watch(CMD_slim, 1, function(widget, stdout)

    local _, user, nice, system, idle, iowait, irq, softirq, steal, _, _ =
        stdout:match('(%w+)%s+(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)%s(%d+)')

    local total = user + nice + system + idle + iowait + irq + softirq + steal

    local diff_idle = idle - tonumber(maincpu['idle_prev'] == nil and 0 or maincpu['idle_prev'])
    local diff_total = total - tonumber(maincpu['total_prev'] == nil and 0 or maincpu['total_prev'])
    local diff_usage = (1000 * (diff_total - diff_idle) / diff_total + 5) / 10

    maincpu['total_prev'] = total
    maincpu['idle_prev'] = idle

    widget:add_value(diff_usage)
    end,
    cpugraph_widget
    )

    --- By default graph widget goes from left to right, so we mirror it and push up a bit
    local cpu_widget = wibox.widget {
    {
        cpugraph_widget,
        reflection = {horizontal = true},
        layout = wibox.container.mirror
    },
    bottom = 2,
    color = background_color,
    widget = wibox.container.margin
    }

    -- Wraps inside an horizontal layout so that is looks like: CPU: graph
    local wrapped_cpu_widget = wibox.widget{
        layout = wibox.layout.align.horizontal,
        expand = 'inside',
		{
            wibox.widget{ markup = '<span foreground= "' .. beautiful.red ..  '">Cpu:</span>', align  = 'center', valign = 'center', widget = wibox.widget.textbox },
            right = dpi(8),
            widget = wibox.container.margin
        },
        cpu_widget

    }

    -- TODO: Popup when the cpu widget is clicked with the info for each core

    return wrapped_cpu_widget
end
