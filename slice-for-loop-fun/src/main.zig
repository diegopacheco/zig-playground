const std = @import("std");

pub fn main() !void {
    
    const message = "Zig Rocks";
    std.debug.print("{s}", .{message});

    var slice = message[3..message.len];

    for(slice) |value| {
        std.debug.print("value [{c}] \n", .{value});
    }

}