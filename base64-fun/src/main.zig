const std = @import("std");
const print = std.debug.print;
const ArrayList = std.ArrayList;
const Codecs = std.base64.standard;

const Person = struct {
    id: u8,
    name: []const u8,
    mail: []const u8,
    allocator: std.mem.Allocator,
    const Self = @This();

    pub fn init(allocator: std.mem.Allocator, id: u8, name: []const u8, mail: []const u8) Self {
        return .{ .allocator = allocator, .id = id, .name = name, .mail = mail };
    }

    pub fn to_slice(self: *Self) ![]const u8 {
        var list = ArrayList(u8).init(self.allocator);
        defer list.deinit();

        try list.append(self.id);
        try list.append(',');
        try list.appendSlice(self.name);
        try list.append(',');
        try list.appendSlice(self.mail);

        return list.toOwnedSliceSentinel(0);
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(allocator, '1', "john", "john@doe.com");
    print("Person id: {d}, name: {s}, email:{s}\n", .{ jd.id, jd.name, jd.mail });

    var list = try jd.to_slice();
    print("look what I got == {s}\n", .{list});

    var buf: []u8 = try allocator.alloc(u8, 10);
    var result: []const u8 = Codecs.Encoder.encode(buf, jd.name);
    print("Base64 {s}\n", .{buf});

    var buffer: []u8 = try allocator.alloc(u8, 10);
    _ = try Codecs.Decoder.decode(buffer, result);
    print("Decoded {s}\n", .{buffer});

    allocator.free(buf);
    allocator.free(buffer);
    allocator.free(list);
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
