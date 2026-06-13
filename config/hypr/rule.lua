-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.window_rule({ match = { class = "steam" }, workspace = "9 silent" })
hl.window_rule({ match = { class = "org.mozilla.Thunderbird" }, workspace = "10 silent" })
hl.window_rule({ match = { class = "discord" }, workspace = "11 silent" })

hl.window_rule({ match = { class = "fullscreen" }, fullscreen = true })
hl.window_rule({ match = { class = "float" }, float = true })
hl.window_rule({ match = { class = "float" }, center = true })
hl.window_rule({ match = { class = "float" }, size = { "monitor_w*0.7", "monitor_h*0.7" } })

hl.window_rule({ match = { class = "explorer.exe" }, opacity = "0.0" })

-- Workaround for GIMP popups not being floating
hl.window_rule({ match = { title = "Export Image as.*" }, float = true })
