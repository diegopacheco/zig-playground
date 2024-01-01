const std = @import("std");
const wrapper = @import("wrapper.zig");

const IntWrapper = wrapper.Wrapper(i32);
pub fn main() !void {
    var w = IntWrapper{
        .value = 10,
    };
    w.print();
}

test "Wrapper test" {
    var w = IntWrapper{
        .value = 42,
    };
    try std.testing.expectEqual(@as(i32, 42), w.get_value());
}
