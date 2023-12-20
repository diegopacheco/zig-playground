const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void {
    char_type();
    direct_concat();
    replace_string_with_char();
    try string_to_int();
    concat_string_with_char();
}

fn char_type() void {
    const c = 'A';
    debug_type(c);
}

fn direct_concat() void {
    const str = "Aaa" ++ "B";
    debug_type(str);
}

fn string_to_int() !void {
    const str = "22";
    const integer = try std.fmt.parseInt(i32, str, 10);
    print("{} converted from string ", .{integer});
    debug_type(integer);
}

fn replace_string_with_char() void {
    var s = "good morning";
    var t = s.*;
    t[0] = 'm';
    std.debug.print("{s} - ", .{t});
    debug_type(t);
}

fn concat_string_with_char() void {}

fn debug_type(t: anytype) void {
    print("Type is {}\n", .{@TypeOf(t)});
}
