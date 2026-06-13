-- https://wiki.hypr.land/Configuring/Start/

require("bind")
require("exec")
require("monitor")
require("rule")
require("workspace")

-- https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 2,
        col = {
            active_border = "rgb(3c78e6)",
            inactive_border = "rgb(505050)",
        },
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        blur = {
            enabled = false,
        },
    },
    -- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
    animations = {
        enabled = false,
    },
    input = {
        kb_layout = "dk",
        kb_options = "caps:super, altwin:menu_win",
        repeat_rate = 50,
        repeat_delay = 250,
        follow_mouse = 1,
    },
    cursor = {
        inactive_timeout = 1,
    },
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        enable_anr_dialog = false,
    },
    -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {
        preserve_split = true, -- you probably want this
        force_split = 2,
        default_split_ratio = 1.1,
    },
})
