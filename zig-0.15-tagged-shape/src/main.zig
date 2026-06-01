const std = @import("std");

const Shape = union(enum) {
    circle: f64,
    square: f64,
    rect: struct { w: f64, h: f64 },

    fn area(self: Shape) f64 {
        return switch (self) {
            .circle => |r| std.math.pi * r * r,
            .square => |s| s * s,
            .rect => |r| r.w * r.h,
        };
    }
};

pub fn main() void {
    const shapes = [_]Shape{
        .{ .circle = 3.0 },
        .{ .square = 4.0 },
        .{ .rect = .{ .w = 5.0, .h = 2.0 } },
    };
    for (shapes) |s| std.debug.print("area = {d:.3}\n", .{s.area()});
}
