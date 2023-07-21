const std = @import("std");
const json = @import("json");

const allocator = std.heap.page_allocator;

const Point = struct { x: i32, y: i32 };
const string =
    \\{
    \\  "x": 1,
    \\  "y": 2
    \\}
;

pub fn main() anyerror!void {
    const point = try json.fromSlice(allocator, Point, string);

    // Point{ .x = 1, .y = 2 }
    std.debug.print("{any}\n", .{point});
}
