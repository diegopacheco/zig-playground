const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void {
    const str = "Aaa" ++ "B";
    debug_type(str);

    var str_temp = "1234567890";
    debug_type(str_temp);

    const c = 'A';
    debug_type(c);
}

fn debug_type(t: anytype) void {
    print("Type is {}\n", .{@TypeOf(t)});
}
