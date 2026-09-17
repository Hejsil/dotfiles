const std = @import("std");

pub fn main(init: std.process.Init) !void {
    const alloc = init.arena.allocator();

    var args_it = try std.process.Args.Iterator.initAllocator(init.minimal.args, alloc);
    _ = args_it.skip(); // program name

    var total: usize = 0;
    while (args_it.next()) |path| {
        const zsrc = try std.Io.Dir.cwd().readFileAllocOptions(init.io, path, alloc, .unlimited, .of(u8), 0);

        var tok = std.zig.Tokenizer.init(zsrc);
        var count: usize = 0;
        while (true) {
            const t = tok.next();
            switch (t.tag) {
                .eof => break,
                .doc_comment, .container_doc_comment => continue,
                else => count += 1,
            }
        }
        total += count;
        std.debug.print("{d:>8}  {s}\n", .{ count, path });
    }
    std.debug.print("{d:>8}  total\n", .{total});
}
