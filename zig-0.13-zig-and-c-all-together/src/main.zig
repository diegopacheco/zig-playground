const std = @import("std");
const math = @import("math.zig");
const testing = std.testing;

const cMath = @cImport({
    @cInclude("cmath.c");
});

pub fn main() !void {
    std.debug.print("Zig: {}  + {} = {} \n", .{ 2, 3, math.add(2, 3) });
    std.debug.print("C  : {} - {} = {} \n", .{ 10, 3, cMath.subtract(10, 3) });
    std.debug.print("C  : {}  * {} = {} \n", .{ 5, 6, cMath.multiply(5, 6) });
}

test "basic add functionality" {
    try testing.expect(math.add(3, 7) == 10);
}
