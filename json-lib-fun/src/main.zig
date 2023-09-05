const std = @import("std");
const json = @import("json");

const allocator = std.heap.page_allocator;
const Point = struct { x: i32, y: i32 };

fn serialization() anyerror!void {
    std.debug.print("Serialization === \n", .{});

    const point = Point{ .x = 1, .y = 2 };
    const string = try json.toSlice(allocator, point);
    defer allocator.free(string);

    // {"x":1,"y":2}
    std.debug.print("{s}\n", .{string});

    // {
    //   "x": 1,
    //   "y": 2
    // }
    std.debug.print("{s}\n", .{try json.toPrettySlice(allocator, point)});
}

fn deserialization() anyerror!void {
    std.debug.print("Deserialization === \n", .{});

    const stringJson =
        \\{
        \\  "x": 1,
        \\  "y": 2
        \\}
    ;
    const pointFromJson = try json.fromSlice(allocator, Point, stringJson);

    // main.Point{ .x = 1, .y = 2 }
    std.debug.print("{any}\n", .{pointFromJson});
}

pub fn main() anyerror!void {
    try serialization();
    try deserialization();
}
