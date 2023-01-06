const std = @import("std");

pub fn main() !void {
    std.debug.print("is {} even? {}.\n", .{232,isEven(232)});
    std.debug.print("is {} even? {}.\n", .{233,isEven(233)});
}

fn isEven(number:usize) bool{
    return if (number%2==0){
        return true;
    } else false;
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
