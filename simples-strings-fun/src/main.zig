const std = @import("std");

pub fn main() !void {
    const string_literal = "banana";
    std.debug.print("String Literal: {s} \n", .{string_literal});

    const multiline_string =
        \\ this is 
        \\ multiline
        \\ String
    ;
    std.debug.print("Multiline String {s} \n", .{multiline_string});

    // Concatenate two strings with ++
    const result = ">> This " ++ " Works? ";
    std.debug.print("String {s} \n", .{result});

    const concat_result = concat_strings("Hello", "World");
    std.debug.print("String Concant function {s} \n", .{concat_result});
}

// Passing and returning Strings, need to be comptime and []const u8
fn concat_strings(comptime a: []const u8, comptime b: []const u8) []const u8 {
    const result = a ++ b;
    return result;
}
