const std = @import("std");

fn userFactory(data: anytype) User {
	const T = @TypeOf(data);
	return .{
		.id = if (@hasField(T, "id")) data.id else 0,
		.power = if (@hasField(T, "power")) data.power else 0,
		.active  = if (@hasField(T, "active")) data.name else true,
		.name  = if (@hasField(T, "name")) data.name else "",
	};
}

pub const User = struct {
	id: u64,
	power: u64,
	active: bool,
	name: [] const u8,
};

pub fn main() !void {
    const user = userFactory(.{
        .name = "Jack Bauer"
    });
    std.debug.print("id {d} \n",.{user.id});
    std.debug.print("power {d} \n",.{user.power});
    std.debug.print("active {} \n",.{user.active});
    std.debug.print("name {s} \n",.{user.name});
}
