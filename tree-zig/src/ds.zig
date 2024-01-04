const std = @import("std");
const dprint = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn BinaryTree(comptime T: type) type {
    const Node = struct {
        allocator: Allocator,
        data: T,
        leftNode: ?*Self,
        rightNode: ?*Self,
        const Self = @This();

        pub fn init(allocator: Allocator, data: T) Self {
            return .{
                .allocator = allocator,
                .data = data,
                .leftNode = null,
                .rightNode = null,
            };
        }

        pub fn addLeft(self: *Self, value: T) !void {
            var newNode: *Self = try self.allocator.create(Self);
            newNode.allocator = self.allocator;
            newNode.leftNode = null;
            newNode.rightNode = null;
            newNode.data = value;
            self.leftNode = newNode;
        }

        pub fn addRight(self: *Self, value: T) !void {
            var newNode: *Self = try self.allocator.create(Self);
            newNode.allocator = self.allocator;
            newNode.leftNode = null;
            newNode.rightNode = null;
            newNode.data = value;
            self.rightNode = newNode;
        }

        pub fn getLeft(self: *Self) ?*Self {
            return self.leftNode;
        }

        pub fn getRight(self: *Self) ?*Self {
            return self.rightNode;
        }

        pub fn getData(self: *Self) T {
            return self.data;
        }

        pub fn inorder_print(node: ?*Self) void {
            if (node) |_| {
                inorder_print(node.?.getLeft());
                dprint("{d} ", .{node.?.getData()});
                inorder_print(node.?.getRight());
            } else {
                return;
            }
        }
    };

    return struct {
        allocator: Allocator,
        rootNode: ?Node,
        const Self = @This();

        pub fn init(allocator: Allocator, data: T) Self {
            var root: Node = Node.init(allocator, data);
            return .{
                .allocator = allocator,
                .rootNode = root,
            };
        }

        pub fn deinit(self: *Self) void {
            if (self.rootNode) |_| {
                if (self.rootNode.?.leftNode) |_| {
                    var temp = self.rootNode.?.leftNode.?;
                    self.allocator.destroy(temp);
                }
                if (self.rootNode.?.rightNode) |_| {
                    var temp = self.rootNode.?.rightNode.?;
                    self.allocator.destroy(temp);
                }
            }
        }

        pub fn print(self: *Self) void {
            if (self.rootNode) |safe_root| {
                @constCast(&safe_root).inorder_print();
            } else {
                dprint("Binary Tree is empty!\n", .{});
            }
        }
    };
}

test "Tree.init and Tree.deinit" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntTree = BinaryTree(i32);
    var tree = IntTree.init(allocator, 1);
    defer _ = tree.deinit();
    try std.testing.expectEqual(@as(i32, 42), 42);
}

test "Tree.addLeft" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntTree = BinaryTree(i32);
    var tree = IntTree.init(allocator, 1);
    defer _ = tree.deinit();

    _ = try tree.rootNode.?.addLeft(2);
    try std.testing.expectEqual(@as(i32, 42), 42);
}

test "Tree.addRight" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntTree = BinaryTree(i32);
    var tree = IntTree.init(allocator, 1);
    defer _ = tree.deinit();

    _ = try tree.rootNode.?.addRight(3);
    try std.testing.expectEqual(@as(i32, 42), 42);
}

test "Tree.getLeft.getData" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntTree = BinaryTree(i32);
    var tree = IntTree.init(allocator, 1);
    defer _ = tree.deinit();

    _ = try tree.rootNode.?.addLeft(3);
    var data = tree.rootNode.?.getLeft().?.getData();
    try std.testing.expectEqual(@as(i32, 3), data);
}
