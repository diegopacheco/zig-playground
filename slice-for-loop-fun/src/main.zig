const std = @import("std");

pub fn main() !void {
    
    std.debug.print("String Array and Slice \n",.{});
    const message = "Zig Rocks";
    std.debug.print("{s}\n", .{message});

    var slice = message[4..message.len];
    for(slice) |value| {
        std.debug.print("value [{c}] \n", .{value});
    }

    std.debug.print("Number Array and Slice \n",.{});
    const array = [_]u32{10,20,30,40,50,60};
    const arraySlice = array[0..array.len];
    for(arraySlice) |value| {
        std.debug.print("value [{d}] \n", .{value});
    }

}