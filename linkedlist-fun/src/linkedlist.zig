const std = @import("std");
const Allocator = std.mem.Allocator;
const dprint = std.debug.print;

pub fn DoubleLinkedList(comptime T: type) type {
    const Errors = error{
        ElementNotFound,
        EmptyList,
    };

    const Node = struct {
        value: T,
        next: ?*Self,
        prev: ?*Self,
        const Self = @This();
    };

    return struct {
        allocator: Allocator,
        count: usize,
        head: ?*Node,
        tail: ?*Node,
        const Self = @This();

        pub fn init(allocator: Allocator) !Self {
            return .{
                .allocator = allocator,
                .head = null,
                .tail = null,
                .count = 0,
            };
        }

        pub fn deinit(self: *Self) void {
            if (self.tail) |_| {
                var current: ?*Node = self.head;
                while (current) |curr| {
                    var temp: *Node = curr;
                    current = curr.next;
                    self.allocator.destroy(temp);
                }
            }
        }

        pub fn add(self: *Self, value: T) !bool {
            var newNode: *Node = try self.allocator.create(Node);
            newNode.value = value;
            newNode.prev = null;
            newNode.next = null;

            if (self.tail) |safe_tail| {
                newNode.prev = safe_tail;
                safe_tail.next = newNode;
            } else {
                self.head = newNode;
            }
            self.tail = newNode;
            self.count += 1;
            return true;
        }

        pub fn get(self: *Self, index: usize) !T {
            if (self.count == 0) {
                return Errors.EmptyList;
            }
            if (index > self.count) {
                return Errors.ElementNotFound;
            }
            if (self.tail) |_| {
                var del_count: usize = 0;
                var current: ?*Node = self.head;
                while (current) |curr| : (current = curr.next) {
                    if (del_count == index) {
                        return curr.value;
                    }
                    del_count += 1;
                }
            }
            return Errors.ElementNotFound;
        }

        pub fn remove_first(self: *Self) !T {
            return remove(self, 0);
        }

        pub fn remove_last(self: *Self) !T {
            return remove(self, self.count - 1);
        }

        pub fn remove(self: *Self, index: usize) !T {
            if (self.count == 0) {
                return Errors.EmptyList;
            }
            if (index > self.count) {
                return Errors.ElementNotFound;
            }
            if (self.tail) |_| {
                var del_count: usize = 0;
                var current: ?*Node = self.head;
                while (current) |curr| : (current = curr.next) {
                    if (del_count == index) {
                        dprint("* Found index for removal \n", .{});

                        var result: T = curr.value;
                        if (curr == self.head) {
                            dprint("* Removing head \n", .{});
                            var temp: *Node = curr;
                            if (curr.next) |_| {
                                var newHead: *Node = curr.next.?;
                                self.head = newHead;
                            } else {
                                self.head = null;
                            }
                            self.allocator.destroy(temp);
                        } else if (curr == self.tail) {
                            dprint("* Removing tail \n", .{});
                            var temp: *Node = curr;
                            var prev: *Node = curr.prev.?;
                            prev.next = null;
                            self.tail = prev;
                            self.allocator.destroy(temp);
                        } else {
                            dprint("* Removing in the middle of the list \n", .{});
                            var temp: *Node = curr.next.?;
                            temp.prev = curr.prev;
                            curr.prev.?.next = curr.next;
                            temp = curr;
                            self.allocator.destroy(temp);
                        }
                        self.count -= 1;
                        return result;
                    }
                    del_count += 1;
                }
            }
            return Errors.ElementNotFound;
        }

        pub fn size(self: *Self) usize {
            return self.count;
        }

        pub fn print(self: *Self) void {
            if (self.tail) |_| {
                dprint(">>> DLL size is: {d}\n", .{self.count});
            } else {
                dprint(">>> DLL is empty!\n", .{});
            }

            var has_elms = false;
            var current: ?*Node = self.head;
            while (current) |curr| : (current = curr.next) {
                dprint(">> element: [{}] ", .{curr.value});
                has_elms = true;
            }
            if (has_elms) {
                dprint("\n", .{});
            }
        }
    };
}

test "DLL.add" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    try std.testing.expectEqual(@as(usize, 1), dll.size());
}

test "DLL.print" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    try std.testing.expectEqual(@as(usize, 1), dll.size());

    dll.print();
}

test "DLL.get" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    var result: i32 = try dll.get(4);
    try std.testing.expectEqual(@as(i32, 5), result);
}

test "DLL.remove tail" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    _ = try dll.remove(4);
    try std.testing.expectEqual(@as(usize, 4), dll.size());
    dll.print();
}

test "DLL.remove head" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    _ = try dll.remove(0);
    try std.testing.expectEqual(@as(usize, 4), dll.size());
    dll.print();
}

test "DLL.remove middle" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    _ = try dll.remove(2);
    try std.testing.expectEqual(@as(usize, 4), dll.size());
    dll.print();
}

test "DLL.remove middle, first to all" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    _ = try dll.remove(2);
    _ = try dll.remove_first();
    _ = try dll.remove_first();
    _ = try dll.remove_first();
    _ = try dll.remove_first();
    try std.testing.expectEqual(@as(usize, 0), dll.size());
    dll.print();
}

test "DLL.remove middle, tail to all" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var alloc = gpa.allocator();

    var dll = try DoubleLinkedList(i32).init(alloc);
    defer dll.deinit();
    _ = try dll.add(1);
    _ = try dll.add(2);
    _ = try dll.add(3);
    _ = try dll.add(4);
    _ = try dll.add(5);
    try std.testing.expectEqual(@as(usize, 5), dll.size());

    _ = try dll.remove(2);
    _ = try dll.remove_last();
    _ = try dll.remove_last();
    _ = try dll.remove_last();
    _ = try dll.remove_last();
    try std.testing.expectEqual(@as(usize, 0), dll.size());
    dll.print();
}
