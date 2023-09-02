const std = @import("std");

fn pointerPrinter(pointer:*i32) void {
    std.debug.print("pointer {} \n", .{pointer});
    std.debug.print("value   {} \n", .{pointer.*});
}

pub fn main() !void {
    var v1:i32 = 41;
    var v2:i32 = 41;

    pointerPrinter(&v1);
    pointerPrinter(&v2);
}

