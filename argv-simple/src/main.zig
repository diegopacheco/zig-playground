const std = @import("std");

pub fn main() !void {
    const argv = std.os.argv;
    std.debug.print("Type {!} \n", .{@TypeOf(argv[0])});
    std.debug.print("Args {any}\n", .{argv});
    std.debug.print("Total Args count {d}\n\n\n", .{argv.len});

    for (argv, 0..) |arg, n| {
        std.debug.print(" arg value: {s} position: {any}\n", .{ arg, n });
    }
}
