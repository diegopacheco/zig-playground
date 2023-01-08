const std = @import("std");

pub fn main() !void {
    const string = [_]u8{ 'a', 'b', 'c', 'd', 'e', 'f' };
    for (string) |character, index| {
        std.debug.print("chart ASCI: {} - {c} index {}\n", .{character,character,index});
    }    
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}