const std = @import("std");

pub fn main() void {
    var n: u32 = 100;
    var steps: u32 = 0;
    while (n != 1) : (steps += 1) {
        std.debug.print("{d} ", .{n});
        if (n & 1 == 0) {
            n /= 2;
        } else {
            n = n * 3 + 1;
        }
    }
    std.debug.print("1\nCollatz from 100 took {d} steps\n", .{steps});
}
