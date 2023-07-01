const std = @import("std");

pub fn main() !void {
    var x: ?u32 = null;
    if (x) |val| {
        std.debug.print("[dont print] x is defined = {any}\n", .{val});
    }

    x = undefined;
    if (x) |val| {
        std.debug.print("[print] x is defined = {any}\n", .{val});
    }

    x = 10;
    if (x) |val| {
        std.debug.print("[print] x is defined = {any}\n", .{val});
    }

    var error_or_value: ?anyerror!u32 = error.ArgNotFound;
    if (error_or_value) |val| {
        std.debug.print("[print] x is defined = {any}\n", .{val});
    }
}
