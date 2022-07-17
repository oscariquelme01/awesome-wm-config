local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

require("modules.bling")

return function(s)

    -- buttons to enable mouse navigation
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
                                  if client.focus then
                                      client.focus:move_to_tag(t)
                                  end
                              end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
                                  if client.focus then
                                      client.focus:toggle_tag(t)
                                  end
                              end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )

    local function update_callback(self, tag, _, _)

        -- switch circle depending on the tag situation
        if tag.selected then
            self:get_children_by_id('background_role')[1].fg = beautiful.pink
            tag.name = 'ﱣ'
        elseif #tag:clients() == 0 then
            self:get_children_by_id('background_role')[1].fg = beautiful.dark_grey
            tag.name = 'ﱤ'
        else
            self:get_children_by_id('background_role')[1].fg = beautiful.light_blue
            tag.name = 'ﱣ'
        end

    end

    local function create_callback(self, tag, _, _)

        -- initial update
        update_callback(self, tag, _, _)

        --- Tag preview
        self:connect_signal("mouse::enter", function()
            if #tag:clients() > 0 then
                awesome.emit_signal("bling::tag_preview::update", tag)
                awesome.emit_signal("bling::tag_preview::visibility", s, true)
            end
        end)

        self:connect_signal("mouse::leave", function()
            awesome.emit_signal("bling::tag_preview::visibility", s, false)
        end)

    end


     -- Setup tags and default layout
     awful.tag({"ﱤ", "ﱤ", "ﱤ", "ﱤ", "ﱤ", "ﱤ", "ﱤ"}, s, awful.layout.suit.tile)

    local taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style  = {
            shape = gears.shape.rounded_rect,
        },
        layout = {
            spacing = 0,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    { -- taglist number background
                        { -- margin
                            { -- taglist number
                                id = 'text_role',
                                widget = wibox.widget.textbox
                            },
                            margins = 7,
                            widget = wibox.container.margin
                        },
                        id = 'background_role',
                        widget = wibox.container.background
                    },
                    {
                        id = 'index_role',
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                right = 4, left = 4,
                top = 8, bottom = 8,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            create_callback = create_callback,
            update_callback = update_callback,
        },
        buttons = taglist_buttons
    })

    return taglist

end
