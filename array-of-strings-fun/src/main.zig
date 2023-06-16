const std = @import("std");

pub fn main() !void {
    var grocery_list: [5][]const u8 = undefined;
    grocery_list[0] = "Beer";
    grocery_list[1] = "Wine";
    grocery_list[2] = "Steak";
    grocery_list[3] = "Fish";
    grocery_list[4] = "Unagui Sauce";
    std.debug.print("Array of Strings {any} \n", .{grocery_list});

    for (grocery_list) |value| {
        std.debug.print("Grocery List item: {s} \n", .{value});
    }
}
