const std = @import("std");

pub const RingBuffer = struct {
    buffer: []u8,
    head: std.atomic.Value(usize) = .{ .raw = 0 },
    tail: std.atomic.Value(usize) = .{ .raw = 0 },
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator, size: usize) !RingBuffer {
        return RingBuffer{
            .buffer = try allocator.alloc(u8, size),
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *RingBuffer) void {
        self.allocator.free(self.buffer);
    }

    pub fn push(self: *RingBuffer, data: []const u8) bool {
        const current_tail = self.tail.load(.acquire);
        const current_head = self.head.load(.acquire);
        const available = (current_head + self.buffer.len - current_tail - 1) % self.buffer.len;

        if (data.len > available) return false;

        for (data, 0..) |byte, i| {
            self.buffer[(current_tail + i) % self.buffer.len] = byte;
        }

        self.tail.store((current_tail + data.len) % self.buffer.len, .release);
        return true;
    }

    pub fn pop(self: *RingBuffer, buffer: []u8) usize {
        const current_head = self.head.load(.acquire);
        const current_tail = self.tail.load(.acquire);
        const available = (current_tail + self.buffer.len - current_head) % self.buffer.len;
        const to_read = @min(buffer.len, available);

        for (0..to_read) |i| {
            buffer[i] = self.buffer[(current_head + i) % self.buffer.len];
        }

        self.head.store((current_head + to_read) % self.buffer.len, .release);
        return to_read;
    }

    pub fn len(self: *RingBuffer) usize {
        const current_head = self.head.load(.acquire);
        const current_tail = self.tail.load(.acquire);
        return (current_tail + self.buffer.len - current_head) % self.buffer.len;
    }
};
