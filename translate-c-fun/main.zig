const std = @import("std");
const sort = @import("sort.zig");

pub fn main() void {
    std.debug.print("hello world!\n", .{});

    var arr = [_]i32{ 4, 2, 3, 1 };
    sort.int_sort(&arr[0], arr.len);
    for (arr) |elem| {
        std.debug.print("{d} ", .{elem});
    }
}
