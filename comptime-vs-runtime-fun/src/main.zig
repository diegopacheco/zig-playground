const std = @import("std");
const expect = @import("std").testing.expect;

fn fibonacci(index: u32) u32 {
    if (index < 2) return index;
    return fibonacci(index - 1) + fibonacci(index - 2);
}

pub fn main() anyerror!void {

    // test fibonacci at run-time
    try expect(fibonacci(7) == 13);

    // test fibonacci at compile-time
    comptime {
        try expect(fibonacci(7) == 13);
    }

    std.log.info("both compiletime fib and runtime ones work ", .{});
}
