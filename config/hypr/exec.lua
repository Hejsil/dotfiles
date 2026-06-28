-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprland-session.target")
    hl.exec_cmd("systemctl --user start plasma-polkit-agent")

    hl.exec_cmd("hyprland-setup-workspace-rules")
    hl.exec_cmd("hypridle")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("systemctl --user stop xdg-desktop-portal-hyprland.service")
    hl.exec_cmd("systemctl --user stop hyprland-session.target")
    hl.exec_cmd("systemctl --user stop graphical-session.target")
end)
