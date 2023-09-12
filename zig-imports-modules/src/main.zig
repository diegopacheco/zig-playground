const std = @import("std");
const user = @import("model/user.zig");
const User = user.User;
const DEFAULT_LUCKY_N = user.DEFAULT_LUCKY_NUM;

pub fn main() !void {
    const john = User{
		.lucky_number = DEFAULT_LUCKY_N,
		.name = "John Doe",
	};
	std.debug.print("{s}'s lucky is {d}\n", .{john.name, john.lucky_number});
}

test "simple test" {
    const john = User{
		.lucky_number = DEFAULT_LUCKY_N,
		.name = "John Doe",
	};
    try std.testing.expectEqualStrings("John Doe", john.name);
    try std.testing.expectEqual(42, john.lucky_number);
}
