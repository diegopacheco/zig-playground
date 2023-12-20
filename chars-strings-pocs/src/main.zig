const std = @import("std");
const print = @import("std").debug.print;
const mem = @import("std").mem;

pub fn main() !void {
    char_type();
    direct_concat();
    replace_string_with_char();
    try string_to_int();
    compare_strings();
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

fn compare_strings() void {
    var result = mem.eql(u8, "hello", "h\x65llo");
    if (result) {
        print("2 strings are equal! \n", .{});
    }
}

fn concat_string_with_char() void {
    //var s = "Hello World";
    //const c = '!';
    //const result = concat(c, s);
    //debug_type(result);
}

fn debug_type(t: anytype) void {
    print("Type is {}\n", .{@TypeOf(t)});
}
