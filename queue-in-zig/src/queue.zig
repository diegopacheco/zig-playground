const std = @import("std");
const dprint = std.debug.print;
const Allocator = std.mem.Allocator;

pub fn Queue(comptime T: type) type {
    const Errors = error{
        ElementNotFoundError,
        QueueIsEmptyError,
    };

    const Node = struct {
        value: T,
        next: ?*Self,
        const Self = @This();
    };

    return struct {
        allocator: Allocator,
        size: usize,
        head: ?*Node,
        tail: ?*Node,
        const Self = @This();

        pub fn init(allocator: Allocator) Self {
            return .{
                .allocator = allocator,
                .size = 0,
                .head = null,
                .tail = null,
            };
        }

        pub fn deinit(self: *Self) void {
            var current = self.head;
            while (current) |curr| {
                var temp = curr;
                current = temp.next;
                self.allocator.destroy(temp);
            }
        }

        pub fn add(self: *Self, value: T) !T {
            var newNode = try self.allocator.create(Node);
            newNode.value = value;
            newNode.next = null;

            if (self.tail) |safe_tail| {
                safe_tail.next = newNode;
            } else {
                self.head = newNode;
            }
            self.tail = newNode;
            self.size += 1;
            return value;
        }

        pub fn poll(self: *Self) !T {
            if (self.tail) |safe_tail| {
                var current: ?*Node = self.head;
                var prev: ?*Node = self.head;
                while (current) |curr| : (current = curr.next) {
                    if (curr == safe_tail) {
                        var temp: *Node = safe_tail;
                        var result: T = safe_tail.value;
                        prev.?.next = null;
                        self.tail = prev;
                        self.allocator.destroy(temp);
                        return result;
                    }
                    prev = curr;
                }
            }
            return Errors.QueueIsEmptyError;
        }

        pub fn size(self: *Self) usize {
            return self.size;
        }

        pub fn print(self: *Self) void {
            dprint(">>> Queue size is {d}\n", .{self.size});
            var has_elem = false;
            if (self.head) |safe_head| {
                dprint(">>> Queue head: [{d}] - tail: [{d}] - elements: \n", .{ safe_head.value, self.tail.?.value });
                var current: ?*Node = safe_head;
                while (current) |curr| : (current = curr.next) {
                    dprint("[{d}] ", .{curr.value});
                    has_elem = true;
                }
            }
            if (has_elem) {
                dprint("\n", .{});
            }
        }
    };
}
