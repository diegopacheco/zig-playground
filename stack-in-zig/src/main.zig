const std = @import("std");
const ds = @import("stack.zig");
const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try ds.Stack(i32).init(allocator);
    defer stack.deinit();

    stack.print();
    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);
    stack.print();

    // If you call no pop you get:
    //  error(gpa): memory address 0x7fccd8dfa000 leaked:
    //  Because we allocated 3 elements and we did not kill them, so we need to deinit.
    // comment lines 24, 25 and 26 to see the issue.

    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();
    stack.print();
}

test "stack.size" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try ds.Stack(i32).init(allocator);
    defer stack.deinit();
    try std.testing.expectEqual(@as(usize, 0), stack.size());
}

test "stack.push and stack.pop" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try ds.Stack(i32).init(allocator);
    defer stack.deinit();

    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);

    try std.testing.expectEqual(@as(usize, 3), stack.size());

    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();

    try std.testing.expectEqual(@as(usize, 0), stack.size());
}
