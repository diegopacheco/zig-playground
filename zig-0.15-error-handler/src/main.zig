const std = @import("std");

const MathError = error{ DivisionByZero, Negative };

fn safeDiv(a: i32, b: i32) MathError!i32 {
    if (b == 0) return MathError.DivisionByZero;
    return @divTrunc(a, b);
}

fn sqrtPositive(x: i32) MathError!i32 {
    if (x < 0) return MathError.Negative;
    return @as(i32, @intFromFloat(@sqrt(@as(f64, @floatFromInt(x)))));
}

pub fn main() void {
    const r1 = safeDiv(10, 2) catch -1;
    const r2 = safeDiv(5, 0) catch |e| blk: {
        std.debug.print("got error: {s}\n", .{@errorName(e)});
        break :blk -1;
    };
    const r3 = sqrtPositive(81) catch -1;
    std.debug.print("10/2={d} 5/0={d} sqrt(81)={d}\n", .{ r1, r2, r3 });
}
