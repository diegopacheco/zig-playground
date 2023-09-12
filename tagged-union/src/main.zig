const std = @import("std");

//
// Will be one of this options but just one and one only.
//
const Number = union {
	int: i64,
	float: f64,
	nan: void,
};

pub fn main() !void {
    const n = Number{.int = 42};
    std.debug.print("{d} \n", .{n.int});
}
