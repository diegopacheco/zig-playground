const std = @import("std");
const print = std.debug.print;
const encoder = std.base64.standard.Encoder;
const decoder = std.base64.standard.Decoder;

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
    var jd = Person.init(1, "John", "john@doe.com");
    print("Person id: {d}, name: {s}, email:{s}\n", .{ jd.id, jd.name, jd.mail });

    var buf: [0x100]u8 = undefined;
    _ = encoder.encode(&buf, jd.name);
    print("Base64 {s}\n", .{buf});

    const decoded = buf[0..try decoder.calcSizeForSlice(&buf)];
    _ = try decoder.decode(decoded, &buf);
    print("Decoded {s}\n", .{decoded});
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
