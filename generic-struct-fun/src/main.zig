const std = @import("std");

fn Vec2Of(comptime T: type) type {
    return struct{
        x: T,
        y: T
    };
}

const V2i64 = Vec2Of(i64);
const V2f64 = Vec2Of(f64);

pub fn main() void {
    var vi = V2i64{.x = 47, .y = 47};
    var vf = V2f64{.x = 47.0, .y = 47.0};
    
    std.debug.print("i64 vector: {}\n", .{vi});
    std.debug.print("f64 vector: {}\n", .{vf});
}