const std = @import("std");
const print = std.debug.print;

pub fn Stack(comptime T: type) type {
    return struct {
        allocator: std.mem.Allocator,
        tail: ?Node,
        const Self = @This();

        const Node = struct {
            value: T,
            prev: ?*Node,
            count: usize,
        };

        pub fn init(allocator: std.mem.Allocator) !Self {
            return .{ .allocator = allocator, .tail = null };
        }

        pub fn deinit(self: Self) void {
            if (self.tail) |t| {
                self.allocator.destroy(t);
            }
        }

        pub fn push(self: Self, value: T) !usize {
            var newNode: Node = .{ .prev = null, .value = value, .count = 1 };
            var count: i32 = 1;
            if (self.tail) |t| {
                newNode.prev = *t;
                newNode.count = t.count + 1;
                count = newNode.count;
                newNode = t;
            } else {
                self.tail = newNode;
                count = newNode.count;
            }
            return count;
        }

        pub fn pop(self: *Self) !T {
            if (self.tail) |t| {
                var result: Node = t;
                self.tail = t.prev;
                return result;
            }
        }

        pub fn size(self: Self) usize {
            if (self.tail) |t| {
                return t.count;
            }
            return 0;
        }

        pub fn print(self: *Self) void {
            var current: Node = self.tail;
            while (current) |curr| {
                std.debug.print(" <- {s} ", .{curr});
                curr = curr.prev;
            }
            std.debug.print("\n", .{});
        }
    };
}
