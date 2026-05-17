const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list: std.ArrayList(i32) = .empty;
    defer list.deinit(allocator);

    var i: i32 = 1;
    while (i <= 10) : (i += 1) try list.append(allocator, i * i);

    var sum: i64 = 0;
    for (list.items) |v| sum += v;

    std.debug.print("squares: ", .{});
    for (list.items) |v| std.debug.print("{d} ", .{v});
    std.debug.print("\nsum of squares 1..10 = {d}\n", .{sum});
}
