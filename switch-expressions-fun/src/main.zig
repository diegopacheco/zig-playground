const std = @import("std");

pub fn main() !void {
    var x: i8 = 10;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    std.debug.print(" x on switch expression == {}\n", .{x});
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
