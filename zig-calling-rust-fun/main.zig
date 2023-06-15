const std = @import("std");
const rustlib = @cImport(@cInclude("rustlib.h"));
 
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const result = rustlib.add(1,2);
    try stdout.print("Result is {d}.\n", .{result});
}