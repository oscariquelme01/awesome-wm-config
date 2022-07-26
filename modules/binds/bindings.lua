local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

require("awful.hotkeys_popup.keys")
require("awful.autofocus")

globalkeys = gears.table.join(
    -- show available keybindings
    awful.key({ modkey, }, "z", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    awful.key({modkey, "Shift"}, "z", function() local file = io.open("debugggg.txt", "a"); file:close() end, {description = "debug", group="awesome"}),

    -- focus previous/next tag
    awful.key({ modkey, }, "Left", awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),

    -- go back to previous tag
    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    -- focus navigation between clients
    awful.key({ modkey, }, "j", function () awful.client.focus.byidx(1) end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, }, "k", function () awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Open terminal
    awful.key({ modkey, }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    -- Restart awesome
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    -- Quit awesome
    awful.key({ modkey, "Shift" }, "e", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    -- Take screenshot
    awful.key({ modkey}, "p", function () awful.util.spawn("flameshot gui") end,
              {description = "take screenshot", group = "screen"}),

    -- Resizing clients
    awful.key({ modkey, }, "l", function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, }, "h", function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),

    -- modify number of master rows
    awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),

    -- modify number of slave columns
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),

    -- switching between layouts
    awful.key({ modkey, }, "space", function () awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    -- Run rofi
    awful.key({ modkey }, "r", function() awful.spawn("rofi -show run", false) end,
              {description = "show the menubar", group = "launcher"}),

    -- switch between screens
    awful.key({ modkey, }, "s", function () awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),

    -- toggle information pannel
    awful.key({ modkey }, "i",
        function ()
            local screen = awful.screen.focused()
            screen.info.toggle() end,
        {description = "toggle information pannel", group = "screen"})
)

-- for loop for everytag list
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- client keybinds. This will be used in rc.lua when aplying the rule for all clients
clientkeys = gears.table.join(
    -- Toggle full screen
    awful.key({ modkey, }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    -- kill window
    awful.key({ modkey, "Shift" }, "q", function (c) c:kill() end,
              {description = "close", group = "client"}),

    -- toggle floating
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),

    -- swap position with next/previous client
	awful.key({ modkey, "Shift" }, "j", function () awful.client.swap.byidx(1) end,
			  {description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift" }, "k", function () awful.client.swap.byidx(-1) end,
              {description = "swap with next client by index reverse", group = "client"}),


    -- toggle keep on top
    awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),

    --minimize/maximize
    awful.key({ modkey, }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey, }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),

        -- Move client to screen
    awful.key({ modkey, }, "o", function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"})
)

-- client buttons. This will be used in rc.lua when aplying the rule for all clients
-- clientbuttons = gears.table.join(
--     awful.button({ }, 1, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--     end),
--     awful.button({ modkey }, 1, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--         awful.mouse.client.move(c)
--     end),
--     awful.button({ modkey }, 3, function (c)
--         c:emit_signal("request::activate", "mouse_click", {raise = true})
--         awful.mouse.client.resize(c)
--     end)
-- )
