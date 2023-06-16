const std = @import("std");
const data = @embedFile("data.txt");

pub fn main() !void {
    var line_it = std.mem.tokenize(u8, data, "\n");
    std.debug.print("Reading data.txt: \n", .{});
    while (line_it.next()) |line| {
        std.debug.print("{s}\n", .{line});
    }
}
