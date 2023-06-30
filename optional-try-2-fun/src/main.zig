const std = @import("std");

pub fn main() !void {
    var result = try print_numbers();
    std.debug.print("Result is {any}\n", .{result});
}

// ! union type between any error and u32
fn print_numbers() anyerror!u32 {
    while (get_numbers_maybe()) |num| {
        std.debug.print("Number {any}\n", .{num});
    }
    std.debug.print("Would this run? yes!\n", .{});
    return 42;
}

// ? means the might be null or u32
fn get_numbers_maybe() ?u32 {
    return null;
}
