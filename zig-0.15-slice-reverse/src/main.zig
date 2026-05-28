const std = @import("std");

fn reverse(comptime T: type, items: []T) void {
    var i: usize = 0;
    var j: usize = items.len;
    while (i < j) {
        j -= 1;
        const tmp = items[i];
        items[i] = items[j];
        items[j] = tmp;
        i += 1;
    }
}

pub fn main() void {
    var nums = [_]i32{ 1, 2, 3, 4, 5, 6, 7 };
    reverse(i32, &nums);
    std.debug.print("reversed nums: ", .{});
    for (nums) |n| std.debug.print("{d} ", .{n});

    var word = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
    reverse(u8, &word);
    std.debug.print("\nreversed word: {s}\n", .{word});
}
