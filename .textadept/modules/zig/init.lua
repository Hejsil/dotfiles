local os = require("os")

events.connect(events.LEXER_LOADED, function (lang)
  if lang ~= 'zig' then
    return
  end

  buffer.tab_width = 4
  buffer.use_tabs = false
end)

events.connect(events.FILE_AFTER_SAVE, function()
  if buffer:get_lexer() ~= 'zig' then
    return
  end

  os.execute([[ zig fmt ]] .. buffer.filename)
  io.reload_file()
end)


return {}