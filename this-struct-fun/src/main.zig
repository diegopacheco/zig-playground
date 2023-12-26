const std = @import("std");
const Point = @import("Point.zig");

pub fn main() !void {
    var p: Point = Point.default();
    std.debug.print("Point {} ", .{p});

    var p2: Point = Point.new(2, 2);
    var diff = Point.distance(p, p2);
    std.debug.print("Ditance {} and {} is == {}", .{ p, p2, diff });
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
