const std = @import("std");
const sb = @import("string_builder.zig");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    var builder = sb.StringBuilder.init(allocator);

    try builder.append("Hello, ");
    try builder.append("world!");
    std.debug.print("StringBuilder contents: {s}\n", .{builder.toString()});

    const result = try builder.finalize();
    defer allocator.free(result);

    std.debug.print("{s}\n", .{result});
}
