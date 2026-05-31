const std = @import("std");

fn grade(score: u8) []const u8 {
    return switch (score) {
        0...59 => "F",
        60...69 => "D",
        70...79 => "C",
        80...89 => "B",
        90...100 => "A",
        else => "invalid",
    };
}

pub fn main() void {
    const scores = [_]u8{ 45, 67, 73, 88, 95, 101 };
    for (scores) |s| {
        std.debug.print("score {d} -> {s}\n", .{ s, grade(s) });
    }
}
