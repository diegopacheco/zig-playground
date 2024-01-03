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

        //
        // Sucks that all fileds in structs are always public
        // here: https://www.reddit.com/r/Zig/comments/13v6q2z/struct_fields_are_always_public_by_design/
        // also sucks there is not interface in zig.
        //
        tail: ?*Node,

        const Self = @This();

        pub fn init(allocator: std.mem.Allocator) !Self {
            return .{ .allocator = allocator, .tail = null };
        }

        pub fn deinit(self: *Self) void {
            var current: ?*Node = self.tail;
            while (current) |c| {
                var temp = c;
                current = c.prev;
                self.allocator.destroy(temp);
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
            newNode.prev = null;
            newNode.count = 1;

            if (self.tail) |t| {
                newNode.count = t.count + 1;
                newNode.prev = t;
            }
            self.tail = newNode;

            return newNode.count;
        }

        pub fn pop(self: *Self) !?T {
            if (self.tail) |t| {
                self.tail = t.prev;
                var value = t.value;
                self.allocator.destroy(t);
                return value;
            }
            return null;
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

        //
        // error: capture shadows declaration of 'tail'
        //       if (self.tail) |tail| {
        // FIX:  if (self.tail) |t| {
        //
        pub fn poll(self: *Self) ?T {
            if (self.tail) |t| {
                return t.value;
            }
            return null;
        }

        //
        // while works because it requires an optional (?) i.e
        // var current:?*Node = self.tail;
        // if enters in the while is because is null-safe and curr has value.
        //
        pub fn print(self: *Self) void {
            std.debug.print("Stack size: {d} \n", .{self.size()});
            var current: ?*Node = self.tail;
            while (current) |c| : (current = c.prev) {
                std.debug.print("element: {d} \n", .{c.value});
            }
            std.debug.print("\n", .{});
        }
    };
}

test "stack.size" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try Stack(i32).init(allocator);
    defer stack.deinit();
    try std.testing.expectEqual(@as(usize, 0), stack.size());
}

test "stack.push and stack.pop" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try Stack(i32).init(allocator);
    defer stack.deinit();

    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);

    try std.testing.expectEqual(@as(usize, 3), stack.size());

    _ = try stack.pop();
    _ = try stack.pop();
    _ = try stack.pop();

    try std.testing.expectEqual(@as(usize, 0), stack.size());
}

test "stack.poll" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try Stack(i32).init(allocator);
    defer stack.deinit();

    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);

    try std.testing.expectEqual(@as(usize, 3), stack.size());

    _ = try stack.pop();
    var r = stack.poll();
    try std.testing.expectEqual(@as(i32, 2), r.?);
    _ = try stack.pop();
    _ = try stack.pop();

    try std.testing.expectEqual(@as(usize, 0), stack.size());
}

test "stack.deinit" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var stack = try Stack(i32).init(allocator);
    defer stack.deinit();

    _ = try stack.push(1);
    _ = try stack.push(2);
    _ = try stack.push(3);
    try std.testing.expectEqual(@as(usize, 3), stack.size());
}
