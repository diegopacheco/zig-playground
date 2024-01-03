const std = @import("std");
const dprint = std.debug.print;
const Allocator = std.mem.Allocator;

const Errors = error{
    ElementNotFoundError,
    QueueIsEmptyError,
};

pub fn Queue(comptime T: type) type {
    const Node = struct {
        value: T,
        next: ?*Self,
        const Self = @This();
    };

    return struct {
        allocator: Allocator,
        count: usize,
        head: ?*Node,
        tail: ?*Node,
        const Self = @This();

        pub fn init(allocator: Allocator) Self {
            return .{
                .allocator = allocator,
                .count = 0,
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
            self.count += 1;
            return value;
        }

        pub fn peek(self: *Self) !T {
            if (self.head) |safe_head| {
                return safe_head.value;
            }
            return Errors.QueueIsEmptyError;
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

                        self.count -= 1;
                        if (self.count == 0) {
                            self.head = null;
                            self.tail = null;
                        }
                        return result;
                    }
                    prev = curr;
                }
            }
            return Errors.QueueIsEmptyError;
        }

        pub fn size(self: *Self) usize {
            return self.count;
        }

        pub fn print(self: *Self) void {
            dprint(">>> Queue size is {d}\n", .{self.size()});
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

test "Queue.add" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntQueue = Queue(i32);
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();

    _ = try iq.add(1);
    _ = try iq.add(2);
    _ = try iq.add(3);
    try std.testing.expectEqual(@as(usize, 3), iq.size());
}

test "Queue.print" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntQueue = Queue(i32);
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();

    _ = try iq.add(1);
    _ = try iq.add(2);
    _ = try iq.add(3);
    try std.testing.expectEqual(@as(usize, 3), iq.size());
    iq.print();
}

test "Queue.peek" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntQueue = Queue(i32);
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();

    _ = try iq.add(1);
    _ = try iq.add(3);
    try std.testing.expectEqual(@as(usize, 2), iq.size());

    var head_val = try iq.peek();
    try std.testing.expectEqual(@as(i32, 1), head_val);
}

test "Queue.poll" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntQueue = Queue(i32);
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();

    _ = try iq.add(1);
    _ = try iq.add(3);
    try std.testing.expectEqual(@as(usize, 2), iq.size());

    _ = try iq.poll();
    _ = try iq.poll();
    try std.testing.expectEqual(@as(usize, 0), iq.size());
}

test "Queue.poll error.QueueIsEmptyError" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    const IntQueue = Queue(i32);
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();

    _ = try iq.add(1);
    _ = try iq.add(3);
    try std.testing.expectEqual(@as(usize, 2), iq.size());

    _ = try iq.poll();
    _ = try iq.poll();
    _ = iq.poll() catch |err| {
        try std.testing.expectError(Errors.QueueIsEmptyError, err);
    };
}
