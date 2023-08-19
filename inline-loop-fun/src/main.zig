const std = @import("std");

pub fn main() !void {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;
    inline for (types) |T| sum += @sizeOf(T);
    std.debug.print("{}", .{sum});
}

test "simple test" {}
