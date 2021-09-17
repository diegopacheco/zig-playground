const std = @import("std");

pub fn main() anyerror!void {

    const value:u64 = 42;
    const result = switch (value) {
        1, 2, 3 => 0,
        5...100 => 1,
        101 => blk: {
            const c:u64 = 5;
            break :blk c * 2 + 1;
        },
        else => 9,
    };

    const print = std.debug.print;
    print("Result from switch is {}\n", .{result});

}
