const std = @import("std");

fn catSays(allocator:std.mem.Allocator) ![]u8 {
    
    var message = [_]u8{'M','E','O','W','!'};
    std.debug.print("catSays.message == {s}\n", .{message});

    var copy = try allocator.dupe(u8, &message);
    return copy;
}

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const catMessage = try catSays(allocator);
    std.debug.print("main.catMessage == {s}",.{catMessage});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
