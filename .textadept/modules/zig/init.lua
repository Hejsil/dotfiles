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

    local stderr = ""
    local p, err = os.spawn([[ zig fmt ]]..buffer.filename, nil, function (str)
        stderr = stderr..str
    end, function (status)
        if status == 0 then
            io.reload_file()
        else
            --ui.print(stderr)
        end
    end)
    if not p then
        print(err)
        return
    end
end)

textadept.editing.autocompleters.zig = textadept.editing.autocompleters.ansi_c

keys.zig = {
  ['s\n'] = function()
    buffer:line_end()
    buffer:add_text(';')
    buffer:new_line()
  end,
}

if type(snippets) == 'table' then
    local mem = [[mem.,std.mem.,,@import("std").mem.]]
    local heap = [[heap.,std.heap.,,@import("std").heap.]]
    local io = [[io.,std.io.,,@import("std").io.]]

    snippets.zig = {
        ---Top level snippets
        main = [[pub fn main() !void {
    %0
}]],
        fn = [[%1{pub ,}fn %2(func)(%3(a: u32)) %4(void) {
    %0
}]],
        test = [[test "%1(Testing snippet)" {
    %0
}]],
        struct = [[%1{pub ,}const %1(Name) = %2{,extern ,packed }struct {
    %0
};]],
        gstruct = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }struct {
        %0
    };
}]],
        union = [[%1{pub ,}const %2(Name) = %3{,extern ,packed }union {
    %0
};]],
        gunion = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }union {
        %0
    };
}]],
        unione = [[%1{pub ,}const %2(Name) = %3{,extern ,packed }union(enum) {
    %0
};]],
        gunione = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }union(enum) {
        %0
    };
}]],
        uniont = [[%1{pub ,}const %2(Name) = %3{,extern ,packed }union(%4(E)) {
    %0
};]],
        guniont = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }union(%5(T)) {
        %0
    };
}]],
        enum = [[%1{pub ,}const %2(Name) = %3{,extern ,packed }enum {
    %0
};]],
        genum = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }enum {
        %0
    };
}]],
        enumt = [[%1{pub ,}const %2(Name) = %3{,extern ,packed }enum(%4(u8)) {
    %0
};]],
        genumt = [[%1{pub ,}fn %2(Name)(comptime %3(T): type) type {
    return %4{,extern ,packed }enum(%5(u8)) {
        %0
    };
}]],
        importp = [[%1{pub ,}const %1(std) = @import("%1");]],
        import = [[%1{pub ,}const %1(file) = @import("%1.zig");]],

        ---Control flow
        ['if'] = [[if (%1(expr)) %0(expr)]],
        ['for'] = [[%1{,inline }for (%2(expr)) |%3(item)| %0(expr)]],
        fori = [[%1{,inline }for (%2(expr)) |%3(item), %4(i)| %0(expr)]],
        ['while'] = [[%1{,inline }while (%2(expr)) %0(expr)]],
        whilei = [[%1{,inline }while (%2(expr)) |%3(capture)| %0(expr)]],
        whilec = [[%1{,inline }while (%2(expr)) : (%3(expr)) %0(expr)]],
        whileic = [[%1{,inline }while (%2(expr)) |%3(capture)| : (%4(expr)) %0(expr)]],

        ---Std snippets
        --std.mem
        eql = [[%1{]]..mem..[[}eql(%2(T), %3(a), %4(b))]],
        swap = [[%1{]]..mem..[[}swap(%2(T), %3(&a), %4(&b))]],
        min = [[%1{]]..mem..[[}min(%2(T), %3(slice))]],
        max = [[%1{]]..mem..[[}max(%2(T), %3(slice))]],
        join = [[try %1{]]..mem..[[}join(%2(allocator), %3(","), [][]const u8{%0})]],
        trim = [[%1{]]..mem..[[}trim(%2(T), %3(slice), %4(values_to_strip))]],
        dupe = [[try %1{]]..mem..[[}dupe(%2(allocator), %3(T), %4(slice))]],
        set = [[%1{]]..mem..[[}set(%2(T), %3(dest), %4(value))]],
        copy = [[%1{]]..mem..[[}%2{copy,copyBackwards}(%3(T), %4(dest), %5(source))]],
        lessThan = [[%1{]]..mem..[[}lessThan(%2(T), %3(lhs), %4(rhs))]],

        --std.heap
        dia = [[var %1(da) = %2{]]..heap..[[}DirectAllocator.init();
defer %1.deinit();
const %3(allocator) = &%1.allocator;]],
        fixa = [=[var %1(buf): [%2(1024)]u8 = undefined;
const %3(fba) = &%4{]=]..heap..[=[}FixedBufferAllocator.init(&%1).allocator;]=],
        tsfixa = [=[var %1(buf): [%2(1024)]u8 = undefined;
const %3(fba) = &%4{]=]..heap..[=[}ThreadSafeFixedBufferAllocator.init(&%1).allocator;]=],
        arenaa = [[var %1(arena) = %2{]]..heap..[[}ArenaAllocator.init(%3(child_alloc));
defer %1.deinit();
const %4(allocator) = &%1.allocator;]],

        --std.io
        stdio = [[const %1(stdin) = &(try %2{]]..io..[[}getStdIn()).inStream().stream;
const %3(stdout) = &(try %2getStdOut()).outStream().stream;
const %4(stderr) = &(try %2getStdErr()).outStream().stream;]]
    }
end

return {}
