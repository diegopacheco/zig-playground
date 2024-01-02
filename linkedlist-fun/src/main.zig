const std = @import("std");
const ds = @import("linkedlist.zig");
const print = std.debug.print;

const IntDoubleLinkedList = ds.DoubleLinkedList(i32);
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try IntDoubleLinkedList.init(alloc);
    defer dll.deinit();
    print("Double Linked List {any}\n", .{dll});

    dll.print();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    _ = try dll.add(6);
    dll.print();

    var result: i32 = try dll.get(1);
    print("Found {any} \n", .{result});

    _ = dll.get(100) catch |err| {
        print("Element not found {any} \n", .{err});
    };

    _ = try dll.remove(3);
    dll.print();
}
