local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local utils = require("utilities.utils")

local tasklist_buttons = gears.table.join(awful.button({ }, 1,
    function (c)
        -- minimize/maximize when left clicked
        if c == client.focus then c.minimized = true
          else c:emit_signal("request::activate","tasklist", {raise = true})
          end
      end))

local alttab_tasklist = awful.popup {
    widget = awful.widget.tasklist {
        screen   = screen[1],
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        style    = {
            shape = utils.rounded_rect(dpi(4)),
            bg_normal = beautiful.black,
            bg_focus = beautiful.dark_grey
        },
        layout   = {
            spacing = 5,
            layout = wibox.layout.grid.horizontal
        },
        widget_template = {
            {
                {
                    {
                            wibox.widget.base.make_widget(),
                            forced_height = 5,
                            id = 'background_role',
                            widget = wibox.container.background,
                            bg = beautiful.green
                        },
                    {
                            id = 'clienticon',
                            widget = awful.widget.clienticon,
                        },
                        layout = wibox.layout.align.horizontal,
                        widget  = wibox.container.margin,
                    },
                    margins = dpi(10),
                    widget = wibox.container.margin
                },
            id = 'background_role',
            forced_width = dpi(99),
            forced_height = dpi(99),
            widget = wibox.container.background,
            create_callback = function(self, c, _, _)
                self:get_children_by_id('clienticon')[1].client = c
            end,
        },
    },
    border_color = beautiful.dark_grey,
    bg = beautiful.black,
    border_width = 2,
    ontop        = true,
    placement    = awful.placement.centered,
    shape        = gears.shape.rounded_rect,
    visible      = false,
}

alttab_tasklist.toggle = function ()
    alttab_tasklist.visible = not alttab_tasklist.visible


end

local clients
local number_clients
local index

local dentro = function ()
    alttab_tasklist.visible = true

    clients = awful.tag.selected(1):clients()
    number_clients = #clients
    index = 1
end
local fuera = function ()
    utils.log(number_clients .. "   " .. index .. "\n")

    alttab_tasklist.visible = false
    if clients[index].minimized then clients[index].minimized = false end
end
local probando = function ()
    index = (index + 1) % (number_clients + 1)
    if index == 0 then index = 1 end
    client.focus = clients[index]

end


awful.keygrabber {
    keybindings = {
    {{modkey }, 'Tab', probando},
    {{modkey, 'Shift'}, 'Tab', probando},
    },
    -- Note that it is using the key name and not the modifier name.
    stop_key           = modkey,
    stop_event         = 'release',
    start_callback     = dentro,
    stop_callback      = fuera,
    export_keybindings = true,
}

screen[1].tasklist = alttab_tasklist
