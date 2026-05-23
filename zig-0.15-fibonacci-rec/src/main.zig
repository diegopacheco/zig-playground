const std = @import("std");

fn fib(n: u32) u64 {
    if (n < 2) return n;
    return fib(n - 1) + fib(n - 2);
}

pub fn main() void {
    var i: u32 = 0;
    while (i < 15) : (i += 1) {
        std.debug.print("fib({d}) = {d}\n", .{ i, fib(i) });
    }
}
