const std = @import("std");

fn nullCheck(pointer: ?*i32) void {
    if (pointer) |value| {
        std.debug.print("value is ok {} \n", .{value.*});
    } else {
        std.debug.print("null pointer \n", .{});
    }
}

pub fn main() !void {
    var value: i32 = 42;
    var vPointer1: ?*i32 = &value;
    var vPointer2: ?*i32 = null;

    nullCheck(vPointer1);

    //
    // if you remove the ? does not work from nullCheck
    // error: expected type '*i32', found '?*i32'
    //
    nullCheck(vPointer2);
}
