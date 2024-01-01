const std = @import("std");
const print = std.debug.print;

pub fn Stack(comptime T: type) type {
    const Node = struct {
        value: T,
        prev: ?*Self,
        count: usize,
        const Self = @This();
    };

    return struct {
        allocator: std.mem.Allocator,
        tail: ?*Node,

        const Self = @This();

        pub fn init(allocator: std.mem.Allocator) !Self {
            return .{ .allocator = allocator, .tail = undefined };
        }

        pub fn deinit(self: *Self) void {
            if (self.tail) |n| {
                self.allocator.destroy(n);
            }
        }

        //
        //  error: cannot assign to constant
        //  pub fn push(self: Self ...
        //  fix: pub fn push(self: *Self ...
        //
        pub fn push(self: *Self, value: T) !usize {
            var newNode: *Node = try self.allocator.create(Node);
            newNode.value = value;

            if (self.tail) |n| {
                newNode.prev = n;
                newNode.count += 1;
            }
            self.tail = newNode;
            return newNode.count;
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

        pub fn poll(self: *Self) ?T {
            if (self.tail) |tail| {
                return tail;
            }
            return null;
        }

        pub fn print(self: *Self) void {
            std.debug.print("Stack size: {d} \n", .{self.size()});
            if (self.tail) |_| {
                var current: Node = @as(Node, self.tail);
                while (current) {
                    std.debug.print("element: {d} \n", .{current.value});
                    current = current.prev;
                }
                std.debug.print("\n", .{});
            }
        }
    };
}
