const std = @import("std");

pub fn main() anyerror!void {
    const MATH = @import("./math/mathutils.zig").MATH_UTILS;
    std.log.info("MATH.sum(4,5)={}", .{MATH.sum(4,5)});

    const MATH2 = @import("./math/mathutils.zig").MATH_UTILS.new(5,5);
    std.log.info("MATH2.mul()={}", .{MATH2.mul()});
}
