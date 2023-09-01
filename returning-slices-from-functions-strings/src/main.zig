const std = @import("std");

fn toString(slice: []u8) usize {
    var message = [_]u8{ 'z', 'i', 'g', ' ', 'r', 'o', 'c', 'k', 's' };
    std.mem.copy(u8, slice, &message);
    return message.len;
}


pub fn main() !void {
    var message:[9]u8 = undefined;
    const len = toString(&message);

    std.log.debug("{s}", .{message[0..len]});
    std.log.debug("{s}", .{message});
}

test "simple test" {
    var expected = [_]u8{ 'z', 'i', 'g', ' ', 'r', 'o', 'c', 'k', 's' };
    
    var message:[9]u8 = undefined;
    _ = toString(&message);
    
    try std.testing.expectEqual(expected,message);
}
