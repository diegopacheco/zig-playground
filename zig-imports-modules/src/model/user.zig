// model/user.zig
const std = @import("std");

pub const DEFAULT_LUCKY_NUM = 42;

pub const User = struct {
	lucky_number: u64,
	name: []const u8,

    pub fn new(name: []const u8, luckyn: u64) User {
        return .{
            .name = name,
            .lucky_number = luckyn,
        };
    }

    pub fn print(user: User) void {
		if (user.lucky_number >= DEFAULT_LUCKY_NUM) {
			std.debug.print("User with default number {s} {d}!!!", .{user.name,user.lucky_number});
		}else{
            std.debug.print("User {s} {d}", .{user.name,user.lucky_number});
        }
	}

};

