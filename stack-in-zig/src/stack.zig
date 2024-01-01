const std = @import("std");
const print = std.debug.print;

pub fn Stack(comptime T: type) type {
    return struct {
        allocator: std.mem.Allocator,

        var tail: ?*Node = undefined;
        const Self = @This();

        const Node = struct {
            value: T,
            prev: ?*Node,
            count: usize,
        };

        pub fn init(allocator: std.mem.Allocator) !Self {
            return .{ .allocator = allocator };
        }

        pub fn deinit(self: *Self) void {
            if (self.tail) |n| {
                self.allocator.destroy(n);
            }
        }

        pub fn push(self: Self, value: T) !usize {
            var newNode: Node = .{ .prev = null, .value = value, .count = 1 };
            var count: usize = 1;
            if (self.tail) |n| {
                newNode.prev = n;
                newNode.count = n.count + 1;
                count = newNode.count;
            } else {
                self.tail = newNode;
                count = newNode.count;
            }
            return count;
        }

        pub fn pop(self: *Self) !T {
            if (self.tail) |t| {
                var result: T = t;
                self.tail = t.prev;
                return result;
            }
        }

        //
        //  error: expected type '*stack.Stack(i32)', found '*const stack.Stack(i32)'
        //  Zig parameters are always immutable thans why implicit const
        //  the fix is: @constCast()
        //  https://stackoverflow.com/questions/75886431/why-do-i-need-constcast-here-is-there-better-way
        //
        pub fn size(self: *Self) usize {
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
