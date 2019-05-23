local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"
local terminal = "alacritty"

local globalkeys =
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
        "Print",
        function()
            awful.spawn.with_shell("~/.scripts/screenshot.sh ~/Pictures")
        end,
        {description = "print screen", group = "launcher"}
    ),
    awful.key(
        {},
        "XF86AudioRaiseVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-mute 1 0 && pactl set-sink-volume 1 +5%", false)
        end
    ),
    awful.key(
        {},
        "XF86AudioLowerVolume",
        function()
            awful.spawn.with_shell("pactl set-sink-volume 1 -5%", false)
        end
    ),
    awful.key(
        {},
        "XF86AudioMute",
        function()
            awful.spawn.with_shell(
                "pactl set-sink-mute 1 `((pactl list sinks | grep -q Mute:.no > /dev/null) && echo 1) || echo 0`",
                false
            )
        end
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
            awful.spawn("rofi -show run")
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

-- Set keys
root.keys(globalkeys)

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
