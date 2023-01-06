const std = @import("std");

pub fn main() !void {
    const va = @Vector(4, i32){ 1, 2, 3, 4 };
    const vb = @Vector(4, i32){ 5, 6, 7, 8 };

    // sum 2 vectors item by item
    const vc = va + vb;    
    std.debug.print("@Vector vc == {}\n", .{vc});

    // Array slice into @Vector
    const slice:[4]u32 = [_]u32{ 1 ,2 ,3 ,4 };
    const offset:u32 = 1;
    const vSlice: @Vector(2, u32) = slice[offset..][0..2].*;
    std.debug.print("@Vector slice vSlice == {}\n", .{vSlice});

}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
