const std = @import("std");

pub fn main() !void {
    const ts_ms = std.time.milliTimestamp();
    const ts_ns = std.time.nanoTimestamp();
    const ts_s = std.time.timestamp();

    std.debug.print("unix seconds      = {d}\n", .{ts_s});
    std.debug.print("unix milliseconds = {d}\n", .{ts_ms});
    std.debug.print("unix nanoseconds  = {d}\n", .{ts_ns});

    const start = std.time.nanoTimestamp();
    var sum: u64 = 0;
    var i: u64 = 0;
    while (i < 1_000_000) : (i += 1) sum += i;
    const elapsed = std.time.nanoTimestamp() - start;

    std.debug.print("sum 0..1_000_000 = {d}\n", .{sum});
    std.debug.print("elapsed ns       = {d}\n", .{elapsed});
}
