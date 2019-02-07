-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

local volume = require("widget.volume")
local mem = require("widget.mem")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
        {
            preset = naughty.config.presets.critical,
            title = "Oops, there were errors during startup!",
            text = awesome.startup_errors
        }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal(
        "debug::error",
        function(err)
            -- Make sure we don't go into an endless error loop
            if in_error then
                return
            end
            in_error = true

            naughty.notify(
                {
                    preset = naughty.config.presets.critical,
                    title = "Oops, an error happened!",
                    text = tostring(err)
                }
            )
            in_error = false
        end
    )
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = "vis"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se
}

local function client_menu_toggle_fn()
    local instance = nil

    return function()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({theme = {width = 250}})
        end
    end
end

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

awful.screen.connect_for_each_screen(
    function(s)
        -- Each screen has its own tag table.
        awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

        s.mypromptbox = awful.widget.prompt()
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(
            gears.table.join(
                awful.button(
                    {},
                    1,
                    function()
                        awful.layout.inc(1)
                    end
                ),
                awful.button(
                    {},
                    3,
                    function()
                        awful.layout.inc(-1)
                    end
                ),
                awful.button(
                    {},
                    4,
                    function()
                        awful.layout.inc(1)
                    end
                ),
                awful.button(
                    {},
                    5,
                    function()
                        awful.layout.inc(-1)
                    end
                )
            )
        )

        -- Add widgets to the wibox
        awful.wibar({position = "top", screen = s}):setup {
            layout = wibox.layout.align.horizontal,
            {
                -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                awful.widget.taglist(
                    s,
                    awful.widget.taglist.filter.all,
                    awful.button(
                        {},
                        1,
                        function(t)
                            t:view_only()
                        end
                    )
                ),
                s.mypromptbox
            },
            {
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                mem.new(),
                volume.new(),
                awful.widget.keyboardlayout(),
                wibox.widget.systray(),
                wibox.widget.textclock(),
                s.mylayoutbox
            }
        }
    end
)

globalkeys =
    gears.table.join(
    awful.key(
        {},
        "F12",
        function()
            awful.spawn(terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key(
        {},
        "F11",
        function()
            awful.spawn("sh -c '~/.scripts/web.sh'")
        end,
        {description = "open a site", group = "launcher"}
    ),
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.spawn("sh -c '~/.scripts/volume-up'")
        end,
        {description = "turn up volume", group = "launcher"}
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.spawn("sh -c '~/.scripts/volume-down'")
        end,
        {description = "turn down volume", group = "launcher"}
    ),
    awful.key(
        {},
        "KP_Add",
        function()
            awful.tag.incmwfact(0.05)
        end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key(
        {},
        "KP_Subtract",
        function()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key(
        {},
        "KP_Enter",
        function()
            awful.screen.focused().mypromptbox:run()
        end,
        {description = "run prompt", group = "launcher"}
    ),
    awful.key(
        {},
        "KP_Right",
        function()
            awful.client.focus.bydirection("right")
        end,
        {description = "focus client right", group = "client"}
    ),
    awful.key(
        {},
        "KP_Left",
        function()
            awful.client.focus.bydirection("left")
        end,
        {description = "focus client left", group = "client"}
    ),
    awful.key(
        {},
        "KP_Up",
        function()
            awful.client.focus.bydirection("up")
        end,
        {description = "focus client up", group = "client"}
    ),
    awful.key(
        {},
        "KP_Down",
        function()
            awful.client.focus.bydirection("down")
        end,
        {description = "focus client down", group = "client"}
    ),
    awful.key(
        {"Shift"},
        "KP_Right",
        function()
            awful.client.swap.bydirection("right")
        end,
        {description = "swap client with client right", group = "client"}
    ),
    awful.key(
        {"Shift"},
        "KP_Left",
        function()
            awful.client.swap.bydirection("left")
        end,
        {description = "swap client with client left", group = "client"}
    ),
    awful.key(
        {"Shift"},
        "KP_Up",
        function()
            awful.client.swap.bydirection("up")
        end,
        {description = "swap client with client up", group = "client"}
    ),
    awful.key(
        {"Shift"},
        "KP_Down",
        function()
            awful.client.swap.bydirection("down")
        end,
        {description = "swap client with client down", group = "client"}
    ),
    awful.key(
        {"Control"},
        "KP_Right",
        function()
            awful.screen.focus_bydirection("right")
        end,
        {description = "focus screen right", group = "screen"}
    ),
    awful.key(
        {"Control"},
        "KP_Left",
        function()
            awful.screen.focus_bydirection("left")
        end,
        {description = "focus screen left", group = "screen"}
    ),
    awful.key(
        {"Control"},
        "KP_Up",
        function()
            awful.screen.focus_bydirection("up")
        end,
        {description = "focus screen up", group = "screen"}
    ),
    awful.key(
        {"Control"},
        "KP_Down",
        function()
            awful.screen.focus_bydirection("down")
        end,
        {description = "focus screen down", group = "screen"}
    ),
    awful.key(
        {},
        "KP_Prior",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next layout", group = "layout"}
    ),
    awful.key(
        {},
        "KP_Home",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous layout", group = "layout"}
    ),
    awful.key({"Shift"}, "KP_Begin", hotkeys_popup.show_help, {description = "show help", group = "awesome"})
)

clientkeys =
    gears.table.join(
    awful.key(
        {},
        "KP_Multiply",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),
    awful.key(
        {"Control", "Shift"},
        "KP_Right",
        function(c)
            c:move_to_screen(c.screen.index + 1)
        end,
        {description = "move client to next screen", group = "client"}
    ),
    awful.key(
        {"Control", "Shift"},
        "KP_Left",
        function(c)
            c:move_to_screen(c.screen.index - 1)
        end,
        {description = "move client to prev screen", group = "client"}
    ),
    awful.key(
        {},
        "KP_Begin",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    )
)

-- Bind all key numbers to tags.
local tag_keys = {
    "KP_End",
    "KP_Down",
    "KP_Next",
    "KP_Left",
    "KP_Begin",
    "KP_Right",
    "KP_Home",
    "KP_Up",
    "KP_Prior"
}

for i, key in pairs(tag_keys) do
    globalkeys =
        gears.table.join(
        globalkeys,
        -- View tag only.
        awful.key(
            {modkey},
            key,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        )
    )
end

clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            client.focus = c
            c:raise()
        end
    ),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            --floating = false,
            maximized_vertical = false,
            maximized_horizontal = false,
            --titlebars_enabled = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq" -- Includes session name in class.
            },
            class = {
                "Arandr",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Wpa_gui",
                "pinentry",
                "veromix",
                "xtightvncviewer"
            },
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }
}

-- Signal function to execute when a new client appears.
client.connect_signal(
    "manage",
    function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- if not awesome.startup then awful.client.setslave(c) end

        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end
)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal(
    "request::titlebars",
    function(c)
        -- buttons for the titlebar
        local buttons =
            gears.table.join(
            awful.button(
                {},
                1,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end
            )
        )

        awful.titlebar(c):setup {
            {
                -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal
            },
            {
                -- Middle
                {
                    -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end
)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal(
    "mouse::enter",
    function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier and awful.client.focus.filter(c) then
            client.focus = c
        end
    end
)

client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal(
    "unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)
