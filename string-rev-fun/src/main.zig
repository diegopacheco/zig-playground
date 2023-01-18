const std = @import("std");

pub fn main() !void {
    comptime var original = "hello";
    std.debug.print("String {s}\n",.{original});
    std.debug.print("Debug {any}\n",.{original});

    var reversed = comptime rev(u8,original.len,original);
    std.debug.print("Reversed {any}\n",.{reversed});
}

fn rev(comptime T: type,comptime size:usize, str: ?[]const T) [size]T {
    var result: [size]u8 = [_]u8{0} ** size;
    var indexStr = size - 1;
    for(str) |index| {
        result[index] = str[indexStr];
        indexStr -= 1;
    }
    return result;
}

test "simple test" {
    try std.testing.expectEqual(@as(i32, 42), 42);
}
