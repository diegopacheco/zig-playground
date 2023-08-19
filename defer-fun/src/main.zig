const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try (expect(x == 5));
    }
    try expect(x == 7);
}
