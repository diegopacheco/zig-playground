const std = @import("std");
const print = @import("std").debug.print;
const mem = @import("std").mem;
const ascii = @import("std").ascii;
const ArrayList = std.ArrayList;

pub fn main() !void {
    char_type();
    direct_concat();
    replace_string_with_char();
    try string_to_int();
    compare_strings();
    char_utils_is_digit_alpha_num();
    try concat_string_with_char();
    simple_coorse_string_with_char();
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

fn char_utils_is_digit_alpha_num() void {
    var num = ascii.isDigit('7');
    var letter = ascii.isAlphabetic('B');
    print("Num: {} Aplha: {} \n", .{ num, letter });
}

fn concat_string_with_char() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var list = ArrayList(u8).init(allocator);
    defer list.deinit();
    try list.appendSlice("Hello World");
    const char = '!';
    try list.appendSlice(&.{char});
    print("concat string with char == {s} - ", .{list.items});
    debug_type(list.items);
}

fn simple_coorse_string_with_char() void {
    const str: []const u8 = "Whats Up";
    const char = '?';
    _ = char;
    const message: []const u8 = str ++ &.{"hello"};
    print("Simple coorse result is == ", .{message});
    debug_type(message);
}

fn debug_type(t: anytype) void {
    print("Type is {}\n", .{@TypeOf(t)});
}
