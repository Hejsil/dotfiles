local zig = {}
local util = require("util")

function zig.load()
    util.snippet("gstructæ", [[fn <c>(comptime T: type) type {return struct {
};}]])
    util.snippet("structæ", "const <c> = struct {\n};")
    util.snippet("enumæ", "const <c> = enum {\n};")
    util.snippet("unionæ", "const <c> = union {\n};")
    util.snippet("unionenumæ", "const <c> = union(enum) {\n};")
    util.snippet("fnæ", "fn <c>() void {\n}")
    util.snippet("ifæ", "if (<c>) {\n}")
    util.snippet("switchæ", "switch (<c>) {\n}")
    util.snippet("foræ", "for (<c>) |item| {\n}")
    util.snippet("foriæ", "for (<c>) |item, i| {\n}")
    util.snippet("whileæ", "while (<c>) {\n}")
    util.snippet("whileiæ", [[var i: usize = 0;
while (i < <c>) : (i += 1) {
}]])
    util.snippet("whileitæ", [[var it = <c>;
while (it.next()) |item| {
}]])
    util.snippet("printæ", [[print("{}\n", .{<c>})]])
end

return zig

