-- https://wiki.hypr.land/Configuring/Basics/Binds/
-- https://wiki.hypr.land/Configuring/Basics/Dispatchers/

-- Launch programs in the terminal
hl.bind("SUPER + Return", hl.dsp.exec_cmd("footclient"))
hl.bind("SUPER + A", hl.dsp.exec_cmd("footclient -a float -e anilist fzf"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("footclient -a float -e fend"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("footclient -a float -e fzf-uni"))
hl.bind("SUPER + G", hl.dsp.exec_cmd("footclient -a float -e fzf-focuswindow"))
hl.bind("SUPER + K", hl.dsp.exec_cmd("footclient -a float -e fzf-kill"))
hl.bind("SUPER + R", hl.dsp.exec_cmd("footclient -a float -e rss-read"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("footclient -a fullscreen -e btop"))

-- Launch other programs
hl.bind("SUPER + B", hl.dsp.exec_cmd("browser"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("obsidian"))
hl.bind("SUPER + O", hl.dsp.exec_cmd("open-clipboard"))
hl.bind("SUPER + P", hl.dsp.exec_cmd("pavucontrol"))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("browser-private"))
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("rss-open-all-in-browser"))
hl.bind("SUPER + Space", hl.dsp.exec_cmd("rofi -show drun"))

-- Screenshot
hl.bind("Print", hl.dsp.exec_cmd("screenshot -m window -m active"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("screenshot -m output"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd("screenshot -m region"))

-- Window manipulation
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind("SUPER + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))

-- Move window with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Change workspace with SUPER + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind("SUPER + " .. key, hl.dsp.exec_cmd("hyprland-change-workspace " .. i))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.exec_cmd("hyprland-move-window-to-workspace " .. i))
end

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume control
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("audio-set-volume 2%+"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("audio-set-volume 2%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("audio-toggle-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightness +5%"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightness 5%-"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("replay-save"))
