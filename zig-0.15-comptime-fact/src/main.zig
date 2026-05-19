const std = @import("std");

fn factorial(comptime n: u32) u64 {
    comptime var result: u64 = 1;
    comptime var i: u32 = 1;
    inline while (i <= n) : (i += 1) {
        result *= i;
    }
    return result;
}

pub fn main() void {
    const f5 = comptime factorial(5);
    const f10 = comptime factorial(10);
    const f15 = comptime factorial(15);
    std.debug.print("5! = {d}\n", .{f5});
    std.debug.print("10! = {d}\n", .{f10});
    std.debug.print("15! = {d}\n", .{f15});
}
