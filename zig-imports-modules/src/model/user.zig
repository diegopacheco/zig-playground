// model/user.zig

pub const DEFAULT_LUCKY_NUM = 42;

pub const User = struct {
	lucky_number: u64,
	name: []const u8,
};

