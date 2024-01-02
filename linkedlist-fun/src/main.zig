const std = @import("std");
const ds = @import("linkedlist.zig");
const print = std.debug.print;

const IntDoubleLinkedList = ds.DoubleLinkedList(i32);
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var alloc = gpa.allocator();
    var dll = IntDoubleLinkedList.init(alloc);
    print("Double Linked List {any}", .{dll});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
