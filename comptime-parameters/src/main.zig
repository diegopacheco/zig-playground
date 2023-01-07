const std = @import("std");

fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) a else b;
}
fn gimmeTheBiggerFloat(a: f32, b: f32) f32 {
    return max(f32, a, b);
}
fn gimmeTheBiggerInteger(a: u64, b: u64) u64 {
    return max(u64, a, b);
}

pub fn main() !void {
    std.debug.print("max int {} and {} is {}.\n", .{20,60,gimmeTheBiggerInteger(20,60)});
    std.debug.print("max flot {} and {} is {}.\n", .{7.4,8.6,gimmeTheBiggerFloat(7.4,8.6)});
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
