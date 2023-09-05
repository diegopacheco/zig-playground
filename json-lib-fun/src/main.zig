const std = @import("std");
const json = @import("json");

const allocator = std.heap.page_allocator;
const Point = struct { 
    x: i32, 
    y: i32 
};

pub fn main() anyerror!void {
    const point = Point{ .x = 1, .y = 2 };

    const string = try json.toSlice(allocator, point);
    defer allocator.free(string);

    // {"x":1,"y":2}
    std.debug.print("{s}\n", .{string});
}