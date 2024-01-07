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

    pub fn to_slice(self: *Self) ![]u8 {
        var list = ArrayList(u8).init(self.allocator);
        defer list.deinit();

        try list.append(self.id);
        try list.append(',');
        try list.appendSlice(self.name);
        try list.append(',');
        try list.appendSlice(self.mail);

        return list.toOwnedSlice();
    }

    pub fn to_encoded(self: *Self) ![]const u8 {
        var buf: []u8 = try self.allocator.alloc(u8, 28);
        var slice: []u8 = try self.to_slice();
        var result: []const u8 = Codecs.Encoder.encode(buf, slice);

        defer self.allocator.free(slice);
        return result;
    }

    pub fn to_decoded(self: *Self, buf: []u8, source: []const u8) !void {
        _ = self;
        _ = try Codecs.Decoder.decode(buf, source);
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(allocator, '1', "john", "john@doe.com");
    print("Person id: {d}, name: {s}, email:{s}\n", .{ jd.id, jd.name, jd.mail });

    var list = try jd.to_slice();
    print("look what I got == [{s}]\n", .{list});

    var enc = try jd.to_encoded();
    print("got encoded [{s}]\n", .{enc});

    var bb: []u8 = try allocator.alloc(u8, 28);
    try jd.to_decoded(bb, enc);
    print("back baby = {s}\n", .{bb});

    //
    //  Base64 encode
    //
    var buf: []u8 = try allocator.alloc(u8, 10);
    var result: []const u8 = Codecs.Encoder.encode(buf, jd.name);
    print("Base64 [{s}]\n", .{buf});

    //
    // Base64 decode
    //
    var buffer: []u8 = try allocator.alloc(u8, 10);
    _ = try Codecs.Decoder.decode(buffer, result);
    print("Decoded [{s}]\n", .{buffer});

    //
    // Client side free memory
    //
    allocator.free(buf);
    allocator.free(buffer);
    allocator.free(list);
    allocator.free(bb);
    allocator.free(enc);
}

test "Person.init" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(allocator, '1', "john", "john@doe.com");
    print("Person id: {d}, name: {s}, email:{s}\n", .{ jd.id, jd.name, jd.mail });

    var name: []const u8 = jd.name;
    var mail: []const u8 = jd.mail;
    try std.testing.expectEqualStrings("john", name);
    try std.testing.expectEqualStrings("john@doe.com", mail);
}

test "Person.to_slice" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(allocator, '1', "john", "john@doe.com");
    var list = try jd.to_slice();
    print("look what I got == [{s}]\n", .{list});

    try std.testing.expectEqualStrings("1,john,john@doe.com", list);
    allocator.free(list);
}

test "Person.to_encoded" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    var allocator = gpa.allocator();

    var jd = Person.init(allocator, '1', "john", "john@doe.com");
    var list = try jd.to_slice();
    print("look what I got == [{s}]\n", .{list});

    var enc = try jd.to_encoded();
    print("got encoded [{s}]\n", .{enc});

    try std.testing.expectEqualStrings("MSxqb2huLGpvaG5AZG9lLmNvbQ==", enc);
    allocator.free(list);
    allocator.free(enc);
}
