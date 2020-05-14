local module = {}
module.rg_path = "rg"
module.rg_args = ""

vis:command_register("rg", function(argv, force, win, selection, range)
    local command = module.rg_path .. " --vimgrep " .. module.rg_args .. " '" .. table.concat(argv, "' '") .. "' | fzf"

    local file = io.popen(command)
    local output = file:read()
    local success, msg, status = file:close()

    if status == 0 then
        for file, line, column in string.gmatch(output, "(.*):(%d*):(%d*):") do
            vis:command(string.format("e '%s'", file))
            vis:feedkeys(string.format("%sgg", line))
            vis:feedkeys(string.format("%dg|", tonumber(column) - 1))
        end
    else
        vis:info(string.format("rg: error"))
    end

    vis:feedkeys("<vis-redraw>")

    return true;
end)

return module
