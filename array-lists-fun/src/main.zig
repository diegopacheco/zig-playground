const std = @import("std");
const ArrayList = std.ArrayList;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var list = ArrayList(u8).init(allocator);
    defer list.deinit();
    try list.append('H');
    try list.append('e');
    try list.append('l');
    try list.append('l');
    try list.append('o');
    try list.appendSlice(" World!");
    std.debug.print("{any} .\n", .{list});

    for(list.items) |e,i|{
        std.debug.print("{} - {c}.\n", .{i,e});
    }
    
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
