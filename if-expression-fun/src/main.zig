const std = @import("std");

fn answer() u8 {
    return 42;
}

pub fn main() !void {
    const result: u8 = answer();
    const display = if (42 == result) "correct" else "incorrect";
    std.debug.print("{s}", .{display});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit();
    try std.testing.expectEqual(@as(i32, 42), answer());
}
