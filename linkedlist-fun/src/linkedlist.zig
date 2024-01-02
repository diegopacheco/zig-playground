const std = @import("std");
const Allocator = std.mem.Allocator;
const dprint = std.debug.print;

pub fn DoubleLinkedList(comptime T: type) type {
    const Node = struct {
        value: T,
        next: ?*Self,
        prev: ?*Self,
        const Self = @This();
    };
    _ = Node;

    return struct {
        allocator: Allocator,
        count: usize,
        const Self = @This();

        pub fn init(allocator: Allocator) !Self {
            return .{
                .allocator = allocator,
                .count = 0,
            };
        }
    };
}
