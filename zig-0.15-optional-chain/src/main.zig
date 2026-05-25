const std = @import("std");

fn findFirstEven(items: []const i32) ?i32 {
    for (items) |x| if (@mod(x, 2) == 0) return x;
    return null;
}

pub fn main() void {
    const a = [_]i32{ 1, 3, 5, 7, 8, 9 };
    const b = [_]i32{ 1, 3, 5, 7 };

    const found = findFirstEven(&a) orelse -1;
    const missing = findFirstEven(&b) orelse -1;
    std.debug.print("found = {d}, missing = {d}\n", .{ found, missing });

    if (findFirstEven(&a)) |v| std.debug.print("if-let got {d}\n", .{v});
}
