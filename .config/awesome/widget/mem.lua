local wibox = require("wibox")
local gears = require("gears")
local io = require("io")
local mem = {}

function mem.new(args)
    local res = wibox.widget.textbox()
    local update = function()
        local p = io.popen("mem", "r")
        local curr = p:read("*number")
        local max = p:read("*number")
        p:close()

        res:set_text(string.format(" mem: %.0f%%", (curr / max) * 100))
    end
    update()
    gears.timer.start_new(1, update)
    return res
end

return mem
