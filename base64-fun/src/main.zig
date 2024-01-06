const std = @import("std");
const print = std.debug.print;
const Codecs = std.base64.standard;

const Person = struct {
    id: usize,
    name: []const u8,
    mail: []const u8,
    const Self = @This();

    pub fn init(id: usize, name: []const u8, mail: []const u8) Self {
        return .{ .id = id, .name = name, .mail = mail };
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(1, "john", "john@doe.com");
    print("Person id: {d}, name: {s}, email:{s}\n", .{ jd.id, jd.name, jd.mail });

    var buf: []u8 = try allocator.alloc(u8, 10);
    var result: []const u8 = Codecs.Encoder.encode(buf, jd.name);
    print("Base64 {s}\n", .{buf});

    var buffer: []u8 = try allocator.alloc(u8, 10);
    _ = try Codecs.Decoder.decode(buffer, result);
    print("Decoded {s}\n", .{buffer});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
