const std = @import("std");

pub fn main() !void {
    const a = null;
    const b = 42;

    // will take a if not null otherwise b
    // for this case a is null so will be b
    const the_anwser = a orelse b;

    std.debug.print("The answer of the universe {any}\n", .{the_anwser});
}
