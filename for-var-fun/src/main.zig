const std = @import("std");

pub fn main() !void {
    const items = [_]u32{10,20,30};

    var sum:u32 = 0;
    for (items) |value| {
        sum += value;
    }

    const result = for (items) |value| {
        if (20==value){
            break value;
        }
    } else 0;

    std.debug.print("{} + {} + {} == {}.\n", .{10,20,30,sum});
    std.debug.print("result is == {}.\n", .{result});
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}

