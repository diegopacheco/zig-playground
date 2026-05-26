const std = @import("std");

fn swap(a: *i32, b: *i32) void {
    const tmp = a.*;
    a.* = b.*;
    b.* = tmp;
}

fn doubleAll(items: []i32) void {
    for (items) |*v| v.* *= 2;
}

pub fn main() void {
    var x: i32 = 10;
    var y: i32 = 99;
    std.debug.print("before: x={d} y={d}\n", .{ x, y });
    swap(&x, &y);
    std.debug.print("after swap: x={d} y={d}\n", .{ x, y });

    var nums = [_]i32{ 1, 2, 3, 4, 5 };
    doubleAll(&nums);
    std.debug.print("doubled: ", .{});
    for (nums) |n| std.debug.print("{d} ", .{n});
    std.debug.print("\n", .{});
}
