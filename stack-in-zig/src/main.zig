const std = @import("std");
const ds = @import("stack.zig");
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    const stack = try ds.Stack(i32).init(allocator);
    print("Stack created[count: {} allocator: {any}] \n ", .{ stack.size(), @TypeOf(stack.allocator) });

    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);
    _ = try stack.print();
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
