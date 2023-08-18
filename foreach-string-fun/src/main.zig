const std = @import("std");

pub fn main() !void {
    const string = "This is a string";
    for (string, 0..) |character, index| {
        std.debug.print("index: {d} char: {c} \n", .{ index, character });
    }
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
