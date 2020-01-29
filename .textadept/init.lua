
buffer:set_theme(not CURSES and 'xresources' or 'term', { font = 'JetBrains Mono', fontsize = 15 })

textadept.file_types.extensions.zig = 'zig'
textadept.file_types.extensions.zen = 'zig'

textadept.editing.strip_trailing_spaces = true

buffer.auto_c_choose_single = false
buffer.additional_selection_typing = true
buffer.h_scroll_bar = false
buffer.v_scroll_bar = false
buffer.tab_width = 4
buffer.use_tabs = false
buffer.view_ws = buffer.WS_VISIBLEALWAYS

ui.tabs = false

function fileExists(name)
    local f = io.open(name,"r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

keys['cg'] = textadept.editing.goto_line
keys['c\n'] = ui.find.find_next
keys['cp'] = function()
    -- Textadepts io.quick_open is really slow when
    -- there are lots of files. I therefor use fd+rofi
    -- for a much faster quick open menu.
    function dirname(str)
        if not str or not str:match(".-/.-") then
            return nil
        end
        return string.gsub(str, "(.*/)(.*)", "%1")
    end

    path = io.get_project_root()
    if not path then path = dirname(buffer.filename) end
    if not path then path = os.getenv("HOME") end
    if not path then return end

    local process = io.popen('rofi-file-picker.sh '..path)
    local file = process:read('*l')

    if not file then return end
    if not fileExists(file) then return end
    io.open_file(file)
end

-- More general system that autoindent
-- Instead of just copying indentation, we copy everything
-- that was common between the two last lines.
textadept.editing.auto_indent = false
events.connect(events.CHAR_ADDED, function(code)
    if code ~= 10 then return end

    local line = buffer:line_from_position(buffer.current_pos)
    if line == 0 then return end

    local curr, _ = buffer.get_line(line)
    if curr:find('%S') ~= nil then
        -- The new line we end up on have none whitespace chars.
        -- This means we pressed enter not at the end of the line.
        -- We just copy the prev lines indentation in this case.
        buffer.line_indentation[line] = buffer.line_indentation[line - 1]
        buffer:vc_home()
        return
    end

    if line == 1 then
        -- If we end on line 1 (lines are zero indexed)
        -- then we don't have two lines to compare, so
        -- just copy indentation.
        buffer.line_indentation[line] = buffer.line_indentation[line - 1]
        buffer:vc_home()
        return
    end

    local prev1, _ = buffer.get_line(line - 1)
    local prev2, _ = buffer.get_line(line - 2)
    local i = 1
    while true do
        local c1 = prev1:sub(i, i)
        local c2 = prev2:sub(i, i)
        if c1 ~= c2 then break end
        if c1 == '' then break end
        if c1 == '\n' then break end

        i = i + 1
    end

    local common = prev1:sub(1, i - 1)
    if common:find('^%s*$') then
        -- If common is only whitespace, then just copy
        -- prev lines ident instead. Example:
        --     s
        --         s
        --          -- this is the new line
        buffer.line_indentation[line] = buffer.line_indentation[line - 1]
        buffer:vc_home()
    else
        buffer:add_text(common)
    end
end)

-- Hide topbar
events.connect(events.INITIALIZED, function()
    ui.menubar = {}
end)

-- Auto refresh when having no unsaved changes
events.connect(events.FILE_CHANGED, function()
    if not buffer.modify then
        local read_only = buffer.read_only
        buffer.read_only = false
        io.reload_file()
        buffer.read_only = read_only
        return true -- stop prompt
    end
end, 1)

-- Args
args.register('-vm', '--view-mode', 0, function()
    events.connect(events.FILE_OPENED, function()
        buffer.read_only = true
    end)
end, 'View-only mode')
