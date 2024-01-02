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
                self.tail = newNode;
            } else {
                self.head = newNode;
                self.tail = newNode;
            }
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
                        if (curr == self.tail) {
                            dprint("* Removing tail \n", .{});
                            var temp: *Node = curr;
                            self.allocator.destroy(temp);
                            self.tail = null;
                        }
                        if (curr == self.head) {
                            dprint("* Removing head \n", .{});
                            var temp: *Node = curr;
                            self.allocator.destroy(temp);
                            self.head = null;
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
    try std.testing.expectEqual(@as(i32, 1), dll.size());
}
