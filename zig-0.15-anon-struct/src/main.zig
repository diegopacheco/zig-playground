const std = @import("std");

fn describe(p: anytype) void {
    std.debug.print("name={s} score={d}\n", .{ p.name, p.score });
}

pub fn main() void {
    describe(.{ .name = "alice", .score = 92 });
    describe(.{ .name = "bob", .score = 78 });

    const point = .{ .x = 10, .y = 20, .z = 30 };
    std.debug.print("point=({d},{d},{d})\n", .{ point.x, point.y, point.z });

    const tuple = .{ "zig", 0.15, true };
    std.debug.print("tuple={s} {d} {}\n", .{ tuple[0], tuple[1], tuple[2] });
}
