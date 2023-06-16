const std = @import("std");

pub fn main() !void {
    var some_integers: [100]i32 = undefined;
    try change_array(&some_integers);

    std.debug.print("Change the array by reference and printing now... \n", .{});
    for (some_integers) |item| {
        std.debug.print("{any} ", .{item});
    }
}

fn change_array(some_integers: *[100]i32) !void {
    var i: usize = 0;
    var values: i32 = 0;
    while (i <= 99) : (i += 1) {
        some_integers[i] = values;
        values += 1;
    }
}
