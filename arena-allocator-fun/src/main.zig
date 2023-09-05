const std = @import("std");
const ArrayList = std.ArrayList;

pub fn main() !void {

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var list = ArrayList(u8).init(allocator);
    defer list.deinit();
    try list.appendSlice("Hello World!");

    std.debug.print("{s}",.{list.items});
}

test "simple arena allocator test" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    _ = try allocator.alloc(u8, 1);
    _ = try allocator.alloc(u8, 10);
    _ = try allocator.alloc(u8, 100);
}
