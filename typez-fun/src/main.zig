const std = @import("std");

pub fn main() !void {

    //
    // There is no Strings in Zig only Byte Arrays so == *const [5:0]u8
    //
    // Array = const [5:0]u8
    // Array length is know is compile time
    // Arrays are values in Zig
    //
    // Slice = const []u8
    // Slice can change in runtime, Slice dont own memory refs memory somewhere else.
    // Slice is ptr + len
    //
    const string_a = "Hello";
    std.debug.print("Type {} .\n", .{@TypeOf(string_a)});
}
