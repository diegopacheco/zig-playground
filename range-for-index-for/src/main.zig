const std = @import("std");

pub fn main() !void {
    for (0..10) |i| {
        std.debug.print("{d} ", .{i});
    }

    for (0..10, 0..) |i, index| {
        std.debug.print("value: {d} index: {d} \n", .{i,index});
    }
}

