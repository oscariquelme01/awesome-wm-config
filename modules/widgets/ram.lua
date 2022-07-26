
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
    local CMD = 'bash -c "LANGUAGE=en_US.UTF-8 free | grep -z Mem.*Swap.*"'

    -- Text containing the percentage of the ram used
    local ramtext_widget = wibox.widget{
        markup = '<span foreground= "' .. beautiful.text ..  '"></span>',
        align  = 'center', valign = 'center',
        widget = wibox.widget.textbox
    }

    -- Widget combining everything ready to be used
    local ram_widget = wibox.widget{
        layout = wibox.layout.align.horizontal,
        expand = 'inside',
        wibox.widget{
            markup = '<span foreground= "' .. beautiful.orange ..  '">Ram:</span>', align  = 'center', valign = 'center', widget = wibox.widget.textbox },
            {
                {
                    ramtext_widget,
                    -- ramgraph_widget,
                    expand = 'none',
                    layout = wibox.layout.align.horizontal,
                },
                widget = wibox.container.margin,
                left = dpi(100)
            }
        }

    watch(CMD, 1,
        function(_, stdout)

            -- aparently lua starts indexing at 1 for some weird reason
            local total, used, _, _, _, _, total_swap, used_swap, _ =
                stdout:match('(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*(%d+)%s*Swap:%s*(%d+)%s*(%d+)%s*(%d+)')

            ramtext_widget.markup = '<span foreground= "' .. beautiful.text ..  '">' .. math.floor(( used + used_swap )/ ( total + total_swap ) * 100 + 0.5).. '%</span>'

        end,
        ram_widget
    )

    return ram_widget
end
