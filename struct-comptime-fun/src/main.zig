const std = @import("std");

pub fn main() !void {
    var a = Range(i32){ .from = 0, .to = 10 };
    std.debug.print("\n[{}, {})\n", .{ a.from, a.to });
}

fn Range(comptime t: type) type {
    return struct {
        from: t,
        to: t,
    };
}

test "range-create" {
    var a = Range(i32){ .from = 0, .to = 10 };
    std.debug.print("\n[{}, {})\n", .{ a.from, a.to });
}