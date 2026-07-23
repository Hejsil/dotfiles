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

-- Steam windows
hl.window_rule({ match = { initial_class = "steam", initial_title = "Friends List" },   float = true, center = true, size = { "monitor_w*0.6", "monitor_h*0.6" } })
hl.window_rule({ match = { initial_class = "steam", initial_title = "Steam Settings" }, float = true, center = true, size = { "monitor_w*0.6", "monitor_h*0.6" } })

-- Blender windows
hl.window_rule({ match = { initial_class = "blender", initial_title = "File Browser" }, float = true, center = true, size = { "monitor_w*0.6", "monitor_h*0.6" } })
hl.window_rule({ match = { initial_class = "blender", initial_title = "Preferences" },  float = true, center = true, size = { "monitor_w*0.6", "monitor_h*0.6" } })
