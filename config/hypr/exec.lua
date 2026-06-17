-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("systemctl --user start plasma-polkit-agent")

    hl.exec_cmd("hyprland-setup-workspace-rules")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("steam")
    hl.exec_cmd("discord")
    hl.exec_cmd("thunderbird")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)
