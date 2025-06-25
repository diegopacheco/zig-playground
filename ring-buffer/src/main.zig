const std = @import("std");
const rb = @import("ring_buffer");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var buffer = try rb.RingBuffer.init(allocator, 10);
    defer buffer.deinit();

    const data1 = "Hello";
    const data2 = "World";

    if (buffer.push(data1)) {
        std.debug.print("Successfully pushed: {s}\n", .{data1});
    }

    if (buffer.push(data2)) {
        std.debug.print("Successfully pushed: {s}\n", .{data2});
    }

    var read_buffer: [20]u8 = undefined;
    while (buffer.len() > 0) {
        const bytes_read = buffer.pop(&read_buffer);
        if (bytes_read > 0) {
            std.debug.print("Popped {} bytes: {s}\n", .{ bytes_read, read_buffer[0..bytes_read] });
        }
    }
}
