const std = @import("std");

pub fn main() !void {

    // Anonimous Union Literal
    // This is ONE or OTHER either have the int or have the float.
    const Number = union {
        int: i32,
        float: f64,
    };
    var i: Number = .{ .int = 42 };
    std.debug.print("Number {any} int {d}", .{ i, i.int });
}
