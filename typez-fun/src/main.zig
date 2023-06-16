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

    // it's optinal because of the "?"
    // if you remove the "?" you can an error:
    // src/main.zig:19:38: error: expected type '[]const u8', found '@TypeOf(null)'
    //     var optional_value: []const u8 = null;
    //                                      ^~~~
    // Because in Zig pointers cannot be null - unless you do "?"
    // Optional pointers "?" have the same size of pointers in Zig.
    //
    var optional_value: ?[]const u8 = null;
    std.debug.print("Type {} .\n", .{@TypeOf(optional_value)});

    // Error Union: anyerror and i32
    //
    var number_or_error: anyerror!i32 = error.ArgNotFound;
    std.debug.print("Type {} .\n", .{@TypeOf(number_or_error)});
    std.debug.print("Value {!} .\n", .{number_or_error});
}
