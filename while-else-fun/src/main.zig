const std = @import("std");

pub fn main() !void {
    while (get_next_number()) |num| {
        std.debug.print("Your number is {d} \n", .{num});
    } else |err| {
        std.debug.print("We got an error [{any}] \n", .{err});
    }
}

fn get_next_number() anyerror!u32 {
    return error.ArgNotFound;
}
