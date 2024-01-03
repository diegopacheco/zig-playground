const std = @import("std");
const print = std.debug.print;
const queue = @import("queue.zig");

const IntQueue = queue.Queue(i32);
pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    var allocator = gpa.allocator();
    var iq = IntQueue.init(allocator);
    defer _ = iq.deinit();
    print("Queue: {} created! \n", .{iq});

    _ = try iq.add(1);
    _ = try iq.add(2);
    _ = try iq.add(3);
    iq.print();

    var head_val = try iq.peek();
    print("Head val is {d} \n", .{head_val});

    _ = try iq.poll();
    iq.print();

    _ = try iq.poll();
    iq.print();

    _ = try iq.poll();
    iq.print();
}
