local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

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

    local function create_callback(self, tag, _, _)

        -- switch circle color depending on the tag situation
        if tag.selected then
            self:get_children_by_id('circle_role').bg = beautiful.light_blue
        elseif #tag:clients() == 0 then
            self:get_children_by_id('circle_role').bg = beautiful.grey
        else
            self:get_children_by_id('circle_role').bg = beautiful.pink
        end

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

    local function update_callback(self, tag, _, _)

        -- switch circle color depending on the tag situation
        if tag.selected then
            self:get_children_by_id('circle_role').bg = beautiful.light_blue
        elseif #tag:clients() == 0 then
            self:get_children_by_id('circle_role').bg = beautiful.grey
        else
            self:get_children_by_id('circle_role').bg = beautiful.pink
        end

    end

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
                { -- taglist number background
                    {
                        { -- taglist number
                            id = 'index_role',
                            widget = wibox.widget.textbox
                        },
                        margins = 4,
                        widget = wibox.container.margin
                    },
                    bg = beautiful.grey,
                    id = 'circle_role',
                    shape = gears.shape.circle,
                    widget = wibox.container.background
                },
                left = 10,
                right = 10,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.margin,
            shape = gears.shape.rounded_rect,
            create_callback = create_callback,
            update_callback = update_callback,
            buttons = taglist_buttons
        }
    })

    return taglist

end
