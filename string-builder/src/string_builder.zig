const std = @import("std");

pub const StringBuilder = struct {
    buffer: std.ArrayList(u8),

    pub fn init(allocator: std.mem.Allocator) StringBuilder {
        return StringBuilder{
            .buffer = std.ArrayList(u8).init(allocator),
        };
    }

    pub fn deinit(self: *StringBuilder) void {
        self.buffer.deinit();
    }

    pub fn append(self: *StringBuilder, text: []const u8) !void {
        try self.buffer.appendSlice(text);
    }

    pub fn appendChar(self: *StringBuilder, char: u8) !void {
        try self.buffer.append(char);
    }

    pub fn appendInt(self: *StringBuilder, value: anytype) !void {
        const text = try std.fmt.allocPrint(self.buffer.allocator, "{d}", .{value});
        defer self.buffer.allocator.free(text);
        try self.append(text);
    }

    pub fn appendFloat(self: *StringBuilder, value: f64, precision: usize) !void {
        const text = try std.fmt.allocPrint(self.buffer.allocator, "{d:.{}}", .{ value, precision });
        defer self.buffer.allocator.free(text);
        try self.append(text);
    }

    pub fn clear(self: *StringBuilder) void {
        self.buffer.clearRetainingCapacity();
    }

    pub fn toString(self: *StringBuilder) []const u8 {
        return self.buffer.items;
    }

    pub fn toOwnedSlice(self: *StringBuilder) ![]u8 {
        return self.buffer.toOwnedSlice();
    }

    pub fn len(self: *StringBuilder) usize {
        return self.buffer.items.len;
    }

    pub fn capacity(self: *StringBuilder) usize {
        return self.buffer.capacity;
    }

    pub fn finalize(self: *StringBuilder) ![]u8 {
        return self.toOwnedSlice();
    }
};
