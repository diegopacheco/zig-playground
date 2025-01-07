const std = @import("std");

fn quadratic(comptime T: type, a: T, b: T, c: T, x: T) T {
    return a * x * x + b * x + c;
}

pub fn main() void {
    const a = quadratic(f32, 21.6, 3.2, -3, 0.5);
    const b = quadratic(i64, 1, -3, 4, 2);
    std.debug.print("Answer: {d}{d}\n", .{ a, b });
}

test "simple test should be 4 and 2" {
    const a = quadratic(f32, 21.6, 3.2, -3, 0.5);
    const b = quadratic(i64, 1, -3, 4, 2);
    try std.testing.expectEqual(@as(f32, a), 4);
    try std.testing.expectEqual(@as(i64, b), 2);
}
