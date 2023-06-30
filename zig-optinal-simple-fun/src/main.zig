const std = @import("std");

pub fn main() !void {
    std.debug.print("Number {any}.\n", .{might_get_number()});
}

fn might_get_number() ?u8 {
    return null;
}
