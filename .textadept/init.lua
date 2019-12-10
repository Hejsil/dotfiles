buffer:set_theme(not CURSES and 'xresources' or 'term', { font = 'monospace', fontsize = 16 })

textadept.file_types.extensions.zig = 'zig'

textadept.editing.strip_trailing_spaces = true

buffer.view_ws = buffer.WS_VISIBLEALWAYS
buffer.tab_width = 4
buffer.use_tabs = false
buffer.additional_selection_typing = true

ui.tabs = false

io.quick_open_max = 50000

lfs.default_filter = {
    '!/build$', '!/build%-release$', '!/zen%-cache$', '!/zig%-cache$',

    -- Hack: Compied from lfs_ext.lua. Idk how to concat the
    --       current lfs.default_filter with more filters.
    --       `lfs.default_filter = lfs.default_filter .. {''}`
    --       doesn't seem to work
    -- File extensions to exclude.
    '!.a', '!.bmp', '!.bz2', '!.class', '!.dll', '!.exe', '!.gif', '!.gz',
    '!.jar', '!.jpeg', '!.jpg', '!.o', '!.pdf', '!.png', '!.so', '!.tar', '!.tgz',
    '!.tif', '!.tiff', '!.xz', '!.zip',
    -- Directories to exclude.
    '!/%.bzr$', '!/%.git$', '!/%.hg$', '!/%.svn$', '!/node_modules$',
}

keys['cg'] = textadept.editing.goto_line
keys['c\n'] = ui.find.find_next
keys['cp'] = io.quick_open

-- More general system that autoindent
-- Instead of just copying indentation, we copy everything
-- that was common between the two last lines.
textadept.editing.auto_indent = false
events.connect(events.CHAR_ADDED, function(code)
    if code ~= 10 then return end

    local line = buffer:line_from_position(buffer.current_pos)
    if line == 0 then return end

    -- If we end on line 1 (lines are zero indexed)
    -- then we don't have two lines to compare, so
    -- just copy indentation
    if line == 1 then
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
    if common:find('^[\t ]*$') then
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
