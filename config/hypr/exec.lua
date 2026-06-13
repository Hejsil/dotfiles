exec-once = systemctl --user start hyprland-session.target
exec-once = systemctl --user start plasma-polkit-agent

exec-once = hyprland-setup-workspace-rules
exec-once = steam
exec-once = discord
exec-once = thunderbird

exec-shutdown = systemctl --user stop hyprland-session.target
