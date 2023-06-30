const std = @import("std");
const sum = @import("sum.zig");

pub fn main() !void {
    const result = sum.sum(3, 3);
    std.debug.print("3 + 3 == {d} \n", .{result});
}
