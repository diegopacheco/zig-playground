const std = @import("std");

const User = struct {
    name: []const u8,
    age: u32,
    active: bool,
    tags: []const []const u8,
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const tags = [_][]const u8{ "admin", "engineer" };
    const user = User{
        .name = "alice",
        .age = 30,
        .active = true,
        .tags = &tags,
    };

    var aw: std.io.Writer.Allocating = .init(allocator);
    defer aw.deinit();

    try std.json.Stringify.value(user, .{ .whitespace = .indent_2 }, &aw.writer);

    std.debug.print("{s}\n", .{aw.written()});
}
