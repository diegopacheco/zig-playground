const std = @import("std");

pub fn main() !void {
    
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    const allocator = std.heap.page_allocator;

    const Point = struct { x: i32, y: i32 };
    var map = std.AutoHashMap(u32, Point).init(allocator);
    defer map.deinit();

    try map.put(1525, .{ .x = 1, .y = -4 });
    try map.put(1550, .{ .x = 2, .y = -3 });
    try map.put(1575, .{ .x = 3, .y = -2 });
    try map.put(1600, .{ .x = 4, .y = -1 });
    var count = map.count();
    var getresult = map.get(1600);
    std.debug.print("HashMap count = {}\n",.{count});
    std.debug.print("HashMap get = {?}\n",.{getresult});

    var sum = Point{ .x = 0, .y = 0 };
    var iterator = map.iterator();
    while (iterator.next()) |entry| {
        sum.x += entry.value_ptr.x;
        sum.y += entry.value_ptr.y;
    }
    std.debug.print("sum from map iterator {}\n",.{sum});
    
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
