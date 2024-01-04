const std = @import("std");
const print = std.debug.print;
const ds = @import("ds.zig");

const IntTree = ds.BinaryTree(i32);
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    var tree = IntTree.init(allocator, 1);
    defer _ = tree.deinit();

    _ = try tree.rootNode.?.addLeft(2);
    _ = try tree.rootNode.?.addRight(3);
    print("Tree {any}\n", .{tree});

    tree.print();
}
