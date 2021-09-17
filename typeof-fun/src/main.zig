const std = @import("std");
const expect = std.testing.expect;

pub fn main() anyerror!void {
    var data:i32 = 42;
    const T = @TypeOf(data);
    comptime try expect(T == i32);
}
