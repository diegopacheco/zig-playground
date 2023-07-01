const std = @import("std");
const Allocator = std.mem.Allocator;

const Config = struct {
    root: struct {
        roots: struct {
            port: []const u8,
        },
    },
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    const config = try readConfig(allocator, "config.json");
    std.debug.print("port: {s}\n", .{config.root.roots.port});
}

fn readConfig(allocator: Allocator, path: []const u8) !Config {
    const data = try std.fs.cwd().readFileAlloc(allocator, path, 512);
    defer allocator.free(data);
    return try std.json.parseFromSlice(Config, allocator, data, .{});
}
