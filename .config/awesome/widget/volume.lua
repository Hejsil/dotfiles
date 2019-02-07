local wibox = require("wibox")
local gears = require("gears")
local io = require("io")
local volume = {}

function volume.new(args)
    local res = wibox.widget.textbox()
    local update = function()
        local p = io.popen("~/.scripts/volume", "r")
        local vol = p:read("*l") or 0
        p:close()

        res:set_text(" vol: " .. vol .. "%")
    end
    update()
    gears.timer.start_new(1, update)
    return res
end

return volume
