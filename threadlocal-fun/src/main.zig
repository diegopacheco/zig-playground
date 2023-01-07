const std = @import("std");
const assert = std.debug.assert;

threadlocal var x: i32 = 1234;

test "thread local storage" {
    const thread1 = try std.Thread.spawn(.{}, testTls, .{});
    const thread2 = try std.Thread.spawn(.{}, testTls, .{});
    testTls();
    thread1.join();
    thread2.join();
}

fn testTls() void {
    assert(x == 1234);
    x += 1;
    assert(x == 1235);
}

pub fn main() !void {
    const thread1 = try std.Thread.spawn(.{}, testTls, .{});
    thread1.join();
    std.debug.print("done",.{});
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
