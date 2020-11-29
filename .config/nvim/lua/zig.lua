local util = require("util")

util.snippet("struct", "const <c> = struct {\n};")
util.snippet("enum", "const <c> = enum {\n};")
util.snippet("union", "const <c> = union {\n};")
util.snippet("unionenum", "const <c> = union(enum) {\n};")
util.snippet("fn", "fn <c>() void {\n}")
util.snippet("if", "if (<c>) {\n}")
util.snippet("switch", "switch (<c>) {\n}")
util.snippet("for", "for (<c>) |item| {\n}")
util.snippet("fori", "for (<c>) |item, i| {\n}")
util.snippet("while", "while (<c>) {\n}")
util.snippet("whilei", [[var i: usize = 0;
while (i < <c>) : (i += 1) {
}]])
util.snippet("whileit", [[var it = <c>;
while (it.next()) |item| {
}]])
util.snippet("print", [[print("{}\n", .{<c>})]])
