const std = @import("std");

fn run() void {
    std.debug.print("start\n", .{});
    defer std.debug.print("defer 1\n", .{});
    defer std.debug.print("defer 2\n", .{});
    defer std.debug.print("defer 3\n", .{});
    {
        defer std.debug.print("inner defer\n", .{});
        std.debug.print("inner block\n", .{});
    }
    std.debug.print("end\n", .{});
}

pub fn main() void {
    run();
}
